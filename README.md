# Netflix review app

## Index
  - [Auth](#Auth)
  - [이름변경](#이름변경)
  - [검색](#검색)

## Dependencies

```swift
- SnapKit
- Alamofire
- Kingfisher
- SwiftyJSON
- IQKeyboardManagerSwift
```

## Auth

<img width="730" alt="스크린샷 2021-10-04 오후 4 24 34" src="https://user-images.githubusercontent.com/93528918/143837211-f5e501e8-9eaf-4449-8646-7d108777b27e.png">

> 회원가입


- parameters에 이메일, 비밀번호, 사용자이름을 서버로 post한다.

```swift
let params = ["email": email, "password": password, "username": username]
```

- 회원가입 시 아래와 같이 제약을 준다.

```swift
if message == "3charater" || message == "1upper" || message == "6password" {
     AlertHelper.defaultAlert(title: "회원가입 오류!", message: "정보를 정확하게 입력해주세요\n(비밀번호는 6자리이상, 이름은 3글자이상 입력해주세요)", okMessage: "확인", over: self)
}
```

> 로그인
>

- parameters에 이메일, 비밀번호를 서버로 post한다.

```swift
let params = ["email": email, "password": password]
```

1. 로그인 페이지에서 로그인 버튼을 누르면, SwiftyJSON 라이브러리를 통해 `username` 과 `accessToken` 을 추출한다.

```swift
// 서버로부터 받는 (추출해야할) json 데이터
{
    message = "login success";
    token = "토큰 값";
    username = "사용자 이름";
}

-------

// 토큰 정보 추출
let username = json["username"].stringValue
let accessToken = json["token"].stringValue
```

2. 추출한 토큰 정보를 키체인에 저장한다.

✓ [Token CRUD]([https://github.com/Netflix-Review/NetflixReview_iOS/blob/main/NetflixReview/Utils/TokenUtils.swift](https://github.com/Netflix-Review/NetflixReview_iOS/blob/main/NetflixReview/Utils/TokenUtils.swift))

```swift
let tk = TokenUtils()
tk.create("\(url)", account: "accessToken", value: accessToken)
tk.create("\(url)", account: "username", value: username)
```

3. 서버에서 결과값에 `"login success"`를 보내면 메인탭으로 전환 전환한다.

```swift
if result == "login success" {
    guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
    guard let tab = window.rootViewController as? MainTabVC else { return }
    tab.checkLoginedUser()
}
```

✓ 메인탭에서 checkLoginedUser() 메서드를 통해 해당 사용자의 토큰을 불러와서, 해당 토큰 값이 있으면 다시 앱을 실행할 때, 로그인페이지가 아닌 메인페이지를 로드한다.

```swift
func checkLoginedUser() {
   let token = tk.load(baseUrl + "/api/login", account: "accessToken")
        
   if ((token?.isEmpty) == nil) {
      DispatchQueue.main.async {
          let nav = UINavigationController(rootViewController: LoginVC())
          nav.modalPresentationStyle = .fullScreen
          self.present(nav, animated: true, completion: nil)
      }
   } else {
      configureViewControllers()
   }
}
```


## 이름변경

<img src = "https://user-images.githubusercontent.com/93528918/143837466-7ef5b601-9abd-48b2-bb44-da9ef8995323.png" width="30%" height="30%">

> 현재 사용자의 이름이 적힌 TextField 에는 프로필 View 와 같이 사용자의 이름을 넣어준다.
> 그리고 변경할 이름을 TextField 에 입력하고 `변경` 버튼을 누른다.
>


- EditInfoCell 의 변경버튼에서 일어나는 이벤트의 코드를 **Delegation Pattern** 으로 처리해준다.

```swift
// EditInfoCell

protocol EditNameDelegate: AnyObject {
    func changeName(_ cell: EditInfoCell)
}

weak var delegate: EditNameDelegate?

// MARK: - Action

@objc func changeName() {
     delegate?.changeName(self)
}
```

```swift
// EditInfoVC

extension EditInfoVC: EditNameDelegate {
    func changeName(_ cell: EditInfoCell) { ... }
}
```

- 서버에 변경한 이름을 업데이트 하기 위해, EditInfoVC 에서 "username" 의 **키체인을 업데이트**해줘야 한다.

✓ [Token CRUD]([https://github.com/Netflix-Review/NetflixReview_iOS/blob/main/NetflixReview/Utils/TokenUtils.swift](https://github.com/Netflix-Review/NetflixReview_iOS/blob/main/NetflixReview/Utils/TokenUtils.swift))

```swift
// EditInfoVC
extension EditInfoVC: EditNameDelegate {
    func changeName(_ cell: EditInfoCell) {
	...
				
	// 키체인 업데이트
	let edit = cell.infoText.text ?? ""
       	self.tk.update("\(tkUrl)", value: edit)
    }
}
```

- 변경이 완료되면 프로필 View 로 다시 넘어가는데, 변경된 "username" 키체인 정보를 **리로드**한다.

```swift
// ProfileVC

override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
	 ... 
     
     // 업데이트해서 저장된 "username"의 값을 로드
     let userName = tk.load(baseUrl + "/api/login", account: "username")
     header.nameLabel.text = "\(userName ?? "")님"
     return header
 }
```

- ProfileVC 의 viewWillAppear 에서 업데이트된 데이터로 collectionView 를 다시 그린다.

```swift
override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     ...
     collectionView.reloadData()
}
```



https://user-images.githubusercontent.com/93528918/143837522-a953584f-d604-4771-b713-b163e986103d.mov




## 검색


✓ Search Bar에 단어를 입력할때마다 서버로 post를 보내서 데이터를 가져올 수 있도록 설계

- 빈 Value 배열을 만들어주고, 서버로 post 보냈을 때 item에 값이 담겨져올 때만 담아서 value에 넣어준다.

```swift
extension ExploreVC: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		var tmp = [Value]()

		... POST

		for item in json.arrayValue {

		... **Value 값**

		     let value = Value(id: id, title: title, post: post, view: view, info: info, des: des, rank: rank, list: list)
		     if item != [] { tmp.append(value) }
		      DispatchQueue.main.async {
		           self.value = tmp
		     }
		}
	}
}
```





