# 진행중 ~

넷플릭스 영상의 **리뷰**를 작성할 수 있는 앱니다.

## ⚒  사용 기술

- Swift
- CocoPods
- SnapKit
- Alamofire
- Kingfisher
- SwiftyJSON
- IQKeyboardManagerSwift


## 뷰 구성

### 홈 


<img src = "https://user-images.githubusercontent.com/74236080/136213731-d213ef37-91e0-487e-a0a7-057ee8790e16.png" width="30%" height="30%">

- collectionView 의 섹션을 나눠 스크롤 뷰 (좌, 우)
- Alamofire 를 사용하여 get 메소드로 각 섹션에 해당하는 데이터를 가져온다.

```swift
   func fetchContentsData() {
        AF.request(self.baseUrl + "/drama", method: .get).validate().responseDecodable(of: [Value].self) { response in
            self.contents = response.value ?? []
            self.collectionView.reloadData()
        }
    }
    
    func fetchMovieData() {
        AF.request(self.baseUrl + "/movie", method: .get).validate().responseDecodable(of: [Value].self) { response in
            self.movies = response.value ?? []
            self.collectionView.reloadData()
        }
    }
    
    func fetchTvData() {
        AF.request(self.baseUrl + "/tv", method: .get).validate().responseDecodable(of: [Value].self) { response in
            self.tvprograms = response.value ?? []
            self.collectionView.reloadData()
        }
    }
```
---

### 검색

<img src = "https://user-images.githubusercontent.com/74236080/136213641-67d791ff-ccbf-4801-96ae-2831b53979e8.png" width="30%" height="30%">

navigation Bar 에서 search Bar 가 바로 나타나지 않는 문제 발생

**viewWillAppear**

view controller의 content view가 앱의 뷰 계층 구조에 추가되기 '바로 전'에 호출된다. 해당 content view가 스크린에 보이기 직전에 실행되어야 할 코드(displaying 관련 코드)가 있다면 이 메서드에 작성하면 된다. 이 메서드를 override 할 때에는 반드시 super를 호출해야 한다.

navigationItem.hidesSearchBarWhenScrolling = false

**viewDidAppear**

view controller의 content view가 앱의 뷰 계층 구조에 추가된 '후'에 호출된다. view가 스크린에 보여지자 마자 실행되어야 할 코드(데이터 불러오기, 애니메이션 시작하기 등)가 있다면 이 메서드에 작성하면 된다. 이 메서드를 override 할 때에는 반드시 super를 호출해야 한다.

navigationItem.hidesSearchBarWhenScrolling = true

뷰의 계층 구조가 추가되기 전(**viewWillAppear**)에 서치바를 숨기지 않는다는 코드를 작성한 뒤, 뷰의 계층 구조가 추가된 후(**viewDidAppear**)에 스크롤할때 서치바를 없애주는 코드를 작성하여 서치바 뷰를 띄웠을 때, 처음에 서치바가 로드되고 스크롤할 때, 서치바가 안보이게 해준다.

---

### 커뮤니티

<img src = "https://user-images.githubusercontent.com/74236080/136213669-cce570c9-09b3-49b3-b651-7a53880fd375.png" width="30%" height="30%">

커뮤니티 상세 페이지로 전환이 될때, 헤더에는 글의 내용을 띄우고, 셀에는 리뷰를 띄우는 뷰로 구성

상세 페이지에서 댓글기능을 적용하기 위해 InputAccesoryView를 추가해준다.

뷰 하단에 InputAccesoryView를 띄우기 위해 tabbar를 없애줘야하는데

**viewWillAppear** 메소드를 통해 "tabBarController?.tabBar.isHidden = true" 코드를 작성하여 뷰 계층 구조가 추가되기 전에 tabbar를 숨겨서 전환했을때 자연스레 InputAccesoryView를 띄워준다.

---

### _프로필

<img src = "https://user-images.githubusercontent.com/74236080/135413848-bd26f389-726e-4b8d-be68-4f070578d127.png" width="30%" height="30%">

뷰 헤더에 필터기능을 줘서 두 섹션을 클릭할 때 애니메이션이 주어지면서 셀의 정보가 바뀌도록 구성

헤더 뷰에 필터바를 추가해서 뷰를 구성하는데, 총 4가지 file을 만들어 구현한다. (ProfileHeader, HeaderFilterView, HeaderFilterCell, HeaderFIlterOptions)

1. HeaderFIlterOptions에 enum으로 케이스를 나눠준다. 각 케이스별 반환할 label을 여기서 설정

```swift
enum HeaderFIlterOptions: Int, CaseIterable {
    case Wish
    case Evaluated
    
    var description: String {
        switch self {
        case .Wish: return "찜한 작품"
        case .Evaluated: return "평가한 작품"
        }
    }
}
```

1. HeaderFilterView에 들어갈 cell을 따로 만들어준다.(HeaderFilterCell)
cell안에 들어가 label값과 isSelected를 bool값으로 줘서 선택했을 때, 폰트사이즈나 텍스트색을 변경해준다.
그리고 HeaderFIlterOptions을 프로퍼티값으로 만들어서 didSet 메서드를 통해 프로퍼티 값(label)의 변경 직전 text를 선택된 case 값으로 변경해준다.
2. ProfileHeader에 들어갈 filterbar인 HeaderFilterView안에는 HeaderFilterCell을 가져와서 UICollectionView 형태로 채워준다. 그리고 view 하단에 layoutSubviews를 통해 underline을 추가해줘서 애니메이션을 적용한다.

```swift
let selectedFirst = IndexPath(row: 0, section: 0)
collectionView.selectItem(at: selectedFirst, animated: true, scrollPosition: .left)
```

위와 같은 코드로 프로필 뷰로 넘어갈 때, 첫번째 값이 적용된 상태로 보이게 한다.

```swift
let cell = collectionView.cellForItem(at: indexPath)
let xPosition = cell?.frame.origin.x ?? 0
UIView.animate(withDuration: 0.1) { self.underLineView.frame.origin.x = xPosition }
```

위의 코드는 선택된 셀로 넘어갈 때 애니메이션을 적용하는 코드

HeaderFilterView에 delegate를 작성하여 ProfileHeader에서 선택된 셀의 값을 알 수 있다.

```swift
HeaderFilterView

protocol HeaderFilterViewDelegate: AnyObject {
    func filterView(_ view: HeaderFilterView, didSelect index: Int)
}
```

---

### _로그인

<img src = "https://user-images.githubusercontent.com/74236080/135412077-ebc462ec-caf0-49fc-a274-25cbf642a361.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/136971221-57cebe3d-6ccb-4324-b8f5-973b62c032c0.png" width="30%" height="30%">



로그인 뷰를 띄울 Slide View와 , Slide View가 띄워질 때 메인뷰가 어두어지게 하기 위해 Container View 이렇게 두개 생성

```swift
(Slide Up)

@objc func goToLogin() {
                
view.addSubview(containerView)
containerView.frame = self.view.frame
containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slideViewDown))
containerView.addGestureRecognizer(tapGesture)
containerView.alpha = 0
        
let screenSize = UIScreen.main.bounds.size
view.addSubview(slideUpView)
slideUpView.backgroundColor = .white
slideUpView.layer.cornerRadius = 15
slideUpView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
slideUpView.frame = CGRect(x: 0, y: screenSize.height,
                           width: screenSize.width, height: slideUpViewHeight)
        
// 슬라이드 뷰 올리기
UIView.animate(withDuration: 0.5,
               delay: 0, usingSpringWithDamping: 1.0,
               initialSpringVelocity: 1.0,
               options: .curveEaseInOut,
               animations: {
                 self.containerView.alpha = 0.8
                 self.slideUpView.frame = CGRect(x: 0,
                                                 y: screenSize.height - self.slideUpViewHeight,
                                                 width: screenSize.width,
                                                 height: self.slideUpViewHeight)
                }, completion: nil)
}
```

```swift
(Slide Down)

@objc func slideViewDown() {
// 뷰 다시 원래 색상으로
UIView.animate(withDuration: 0.5,
               delay: 0, usingSpringWithDamping: 1.0,
               initialSpringVelocity: 1.0,
               options: .curveEaseInOut,
               animations: {
	               self.containerView.alpha = 0
               }, completion: nil)
        
// 슬라이드 뷰 내려감
let screenSize = UIScreen.main.bounds.size
UIView.animate(withDuration: 0.5,
               delay: 0, usingSpringWithDamping: 1.0,
               initialSpringVelocity: 1.0,
               options: .curveEaseInOut,
               animations: {
                  self.containerView.alpha = 0
                  self.slideUpView.frame = CGRect(x: 0, y: screenSize.height,
                                                  width: screenSize.width, height: self.slideUpViewHeight)
               }, completion: nil)
}

```

https://user-images.githubusercontent.com/74236080/136971537-c89056b1-1de5-427a-8659-1b94378d0887.mov


---

### Alamofire

백단에서 데이터를 get, post 하기 위해 **Alamofire 라이브러리** 사용

> Get
> 

메인 홈 뷰에서 섹션별 데이터가 필요하다.

Alamofire 라이브러리 사용하여 데이터를 가져오기 위한 코드 (섹션별로 생성)

enum으로 type별로 url을 넣으려했지만, DataSource에서 섹션별 데이터를 구성하기 위해 섹션별로 프로퍼티를 나눠줘야했다.

```swift
func fetchContentsData() {
   AF.request(self.baseUrl + "/drama", method: .get).validate().responseDecodable(of: [Value].self) { response in
        self.contents = response.value ?? []
        self.collectionView.reloadData()
   }
}
```

위와 같은 코드를 섹션 개수만큼 구성

```swift
 AF.request(self.baseUrl + "/drama", method: .get)
			.validate().responseDecodable(of: [Value].self)
```

Alamofire 라이브러리 사용하여 백단에 송신

"self.baseUrl + "/drama", method: .get" → 해당 url과 get임을 명시해주고,

".validate().responseDecodable(of: [Value].self)" → 유효성을 검사하고, 원하는 모델로 바로 디코딩해서 반환해준다.

***responseDecodable***

_  Alamofire에서는 자동으로 Decodable 객체를 response로 설정하면 파싱하여 데이터를 넘겨주도록 되어있다.

이전의 방식은 아래와 같이 통신이 성공하면 디코딩을 해주고 모델에 맞게 해줬었는데 위의 코드는 이작업을 한번에 해서 모델이 반환된다.

```swift
let decoder = JSONDecoder()
let json = try = decoder.decode([Value].self, from: result)
```

이 과정을 통해 메인 홈 뷰에서 각 섹션별 프로퍼티의 값을 reloadData 해서 필요한 값만 view에 띄운다.

```swift
HomeCell

var contents: Value! {
     didSet {
         self.titleLabel.text = self.contents.title
         self.postImageView.setImage(imageUrl: self.contents.post)
     }
}
    
var movie: Value! {
     didSet {
        self.titleLabel.text = self.movie.title
        self.postImageView.setImage(imageUrl: self.movie.post)
     }
}
    
var tvprogram: Value! {
     didSet {
         self.titleLabel.text = self.tvprogram.title
         self.postImageView.setImage(imageUrl: self.tvprogram.post)
     }
}
```

---

> Post
> 

메인 홈 뷰에서 post 뷰로 넘어갈 때 이전에 받아온 모든 데이터도 같이 넘어간다.

```swift
override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let controller = PostViewController()
    
    if indexPath.section == 0 {
        controller.value = contents[indexPath.row]
    } else if indexPath.section == 1 {
        controller.value = movies[indexPath.row]
    } else if indexPath.section == 2 {
        controller.value = tvprograms[indexPath.row]
    }
        
    navigationController?.pushViewController(controller, animated: true)
}
```

각 섹션별로 받은 url 주소에 있는 데이터에서 변경되는 값인 퍼센트 값을 업데이트하기 위해 백단에 post를 한다.

그런데 url 별로 플러스/마이너스하는 함수를 만들면 코드가 지저분하고 비효율적이므로 enum을 사용

```swift
enum Type {
    case drama
    case movie
    case tv
}
```

이 값을 플러스, 마이너스 함수안에서 switch case 구문으로 구분해서 request에 적용한다.

```swift
var urlString = ""
        
switch type {
case .drama: urlString = "/drama"
case .movie: urlString = "/movie"
case .tv: urlString = "/tv"
 }
        
var request = URLRequest(url: URL(string: baseUrl + urlString)!)
```

---

***post 과정***

1차 -> 틀림 ❌

```swift
var request = URLRequest(url: URL(string: baseUrl + urlString)!)
request.httpMethod = "POST"
        
print(value?.rank ?? 0)
value?.rank -= 1
print(value?.rank ?? 0)
        
let params = ["rank": value?.rank ?? 0] as Dictionary

// 1      
do {
    try request.httpBody = JSONSerialization.data(withJSONObject: params)
 } catch {
    print("http Body error")
 }

// 2       
AF.request(request).responseString { respone in
	// 4
   switch respone.result {
      case .success: print("POST 성공 \(params)")
      case .failure(let error): print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
    }
}

// 3
collectionView.reloadData()
```

1. http 본문(추후 response 값)에 파라미터 객체를 JSON 데이터로 생성

*withJSONObject: JSON 데이터를 생성할 개체, options: JSON 데이터를 생성하기 위한 옵션*

2. AF.request(request) - 백단에 request를 송신, 
.responseString - 서버로부터 응답을 받기 위해 문자열로 처리한 후 서버에 전달

*서버로부터 응답을 받기 위한 메소드 - responseString: 응답결과를 문자열로 처리한 후 전달한다.
서버로부터 JSON 데이터를 응답받아서 문자열로 처리*

1. 요청한 데이터를 백단에서 반환한 데이터로 받아서 리로드

1. respone.result 여기로 와서 성공이면 View에 값 업데이트

- 로딩 뷰를 띄우기 위해 DispatchQueue.main.async식으로 비동기작업을 위해 그 안에 값을 넣었다.

*데이터가 처리되는 동안 로딩뷰를 띄우기 위해*

(DispatchQueue.main.async로 처리하지 않으면 데이터가 변경되고 뷰에 업데이트되고 난뒤 잠시 로딩뷰가 띄워지고 없어진다.)

스레드에 관해서 공부하고 로딩뷰도 추가해보니까 원래 do catch 문에서 시작했던 과정은 처리할 작업이 데이터를 넘기고 받아와서 띄우는 이 작업뿐이라서 따로 스레드에 관한 처리를 안해줬었는데 로딩뷰를 추가해보니까 데이터를 넘겨받는 작업이 끝나고 로딩뷰가 잠깐 띄어졌다.

그래서 DispatchQueue.main.async를 추가해서 비동기로 처리해서 데이터받는 작업동안 로딩뷰가 띄워줄 수 있게 처리

그래서 이 함수 내의 전체적인 순서가 DispatchQueue.main.async 서부터 시작해서 var request 라인에서 요청 프로퍼티를 가져와서 주석처리된과정을 수행함과 동시에 로딩뷰는 데이터가 리로드해서 결과가 나올때까지 있다가 응답결과가 나오면서 사라지는 과정으로 이해

좀 헷갈렸던게 responseString 이거처럼 서버로부터 응답받기 위한 메소드가 여러개 있는데, 내가 이해한건 params의 딕셔너리 값을 JSONSerialization을 통해 JSON 데이터로 변환 -> responseString메서드는 문자열로 처리한 후 백단에 전달하고 문자열로 반환을 받는건데 이건 확실하게 이해가 안됐음

```swift
func minusPercentCount() {
        
var urlString = ""
        
switch type {
case .drama: urlString = "/drama"
case .movie: urlString = "/movie"
case .tv: urlString = "/tv"
}
        
// 2
var request = URLRequest(url: URL(string: baseUrl + urlString)!)
request.httpMethod = "POST"
        
value?.rank -= 1
        
let params = ["rank": value?.rank ?? 0] as Dictionary
        
// 1
DispatchQueue.main.async {
// 3
do {
	   try request.httpBody = JSONSerialization.data(withJSONObject: params)
    } catch {
     print("http Body error")
    }
            
    AF.request(request).responseString { respone in
        switch respone.result {
        case .success: print("POST 성공 \(params)")
        case .failure(let error): print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        }
    }
    self.collectionView.reloadData()
    self.hud.dismiss()
}
```

---

**⬆️ 틀렸다.**

지금 순서가 그린다음 -> 데이터 로 잘못됐음

> **Alamofire 자체가 비동기로 처리되기 때문에** 이 라이브러리를 쓰는 이유라고 보면 될거같다.
> 

**메인 스레드**

AF.request 요청하면 2번 스레드로 ⇓

**2번 스레드**

responseJSON 핸들러 안 로직 처리

처리가 끝나면 DispatchQueue.main.async 을 통해 메인스레드로 넘김 ⥣

```swift
func plusPercentCount() {
        
   // 1. urlString 변수를 초기화
   var urlString = ""
        
   // 2. 타입에 따라 url 스트링에 필요한 값을 대입
   switch type {
   case .contents: urlString = "/plus"
   case .movie: urlString = "/plus"
   case .tv: urlString = "/plus"
   }
        
   // 3. 해당 뷰에 로딩뷰를 띄움
   self.hud.show(in: self.view)
        
   // 4. url 변수 생성 - 기본 베이스 url에 타입에 따른 값을 대입해서 URL을 생성
   let url = URL(string: baseUrl + urlString)!
   // 5. 백단으로 보낼 파라미터 생성
   let params = ["id": value?.id ?? 0, "rank": "Up"] as Dictionary
        
    // 6. Alamofire 라이브러리로 해당 url 에 요청
    AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"])
				
    // 7. Alamofire 를 사용함으로써 응답 처리는 다른 스레드로 보내진다.
    .responseJSON { response in
            
     print("HTTP Body : " + String(decoding: response.request?.httpBody ?? Data(), as: UTF8.self))
            
     switch response.result {
     case .success(let data):
        print("POST 성공 \(response.result)")
                
      do {
								
      **// SwiftyJSON 으로 받아온 값 파싱**
										
      	    // 성공적으로 처리가 끝나면 메인스레드로 넘어가서 나머지 작업
      	    DispatchQueue.main.async {
          	 self.collectionView.reloadData()
          	 self.hud.dismiss()
      	     }
                    
       } catch {
             print(error)
       }
                
       case .failure(let error):
          print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        }
    }
}
```
---

**SwiftyJSON 으로 받아온 값 파싱**

아래 코드와 같이 받아온 데이터를 구조체를 디코딩하게 되면 필요없는 값까지 굳이 옵셔널로 처리해서 가져오지도 못한다. 

내가 받아와야하는 값은 rank = 71; 에서 71만 필요하기 때문에 새로운 구조체를 만들어서 이값만 받아와야하는데 이과정을 **SwiftyJSON 라이브러리**를 사용해서 파싱해와야한다.


```swift
switch response.result {
case .success(let data):
                
     let json = JSON(data)
     let result = json[0]["rank"].intValue
                
     self.value?.rank = result
                
     DispatchQueue.main.async {
          self.collectionView.reloadData()
          self.hud.dismiss()
     }
                
case .failure(let error):
      print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
}
```

> 결과값
> 

![image](https://user-images.githubusercontent.com/74236080/135412598-18bdb66c-cb49-4baf-84ba-7bc0197505e8.png)



<img src = "https://user-images.githubusercontent.com/74236080/135412671-9044728f-0750-460d-bb79-f9f237f3ab35.png" width="30%" height="30%">

해당 퍼센트 값을 +1 씩 올리는 것으로 테스트

---

### 일반 로그인

> 회원가입
> 

1. 이메일, 비밀번호, 이름을 서버에 전송
2. 성공 → 알림 → 로그인 페이지로 전환

```swift
  @objc func handleSignUp() {
        print("회원가입")
        guard let email = emailTextField.text else { return }
        guard let password = passwordField.text else { return }
        guard let username = nameField.text else { return }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "회원가입 중"
        hud.show(in: view)
        
        let url = URL(string: baseUrl + "/api/sign-up")!
        let params = ["email": email, "password": password, "username": username]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"])
					.responseJSON { response in
            
            switch response.result {
            case .success(let data):
                print("성공, \(data)")
                
                let alertSheet = UIAlertController(title: "환영합니다 👏👏",
                                                    message: "회원가입을 완료했습니다!",
                                                    preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "로그인 하러가기", style: .default) { _ in
                    let controller = EmailLoginVC()
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                
                alertSheet.addAction(okAction)
                self.present(alertSheet, animated: true, completion: nil)
                
                hud.dismiss()
                
            case .failure(let error):
                print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
```

> 로그인
> 


<img src = "https://user-images.githubusercontent.com/74236080/136214417-8ddaa431-2e3b-4222-8997-2966c6f141d2.png" width="80%" height="80%">

1. 이메일과 비밀번호를 서버로 전송
2. 서버에서 해당 데이터가 일치하는지 판별 후, JWT 발행
3. 전달받은 JWT 를 저장

서버에서 로그인 인증을 마치면 `SwiftyJSON` 를 통해, *"message"* 가 *"login success"* 를 띄우면 (토큰 값도 함께 발행), 메인탭으로 전환한다. 여기서 메인탭의 `isLogin` 값을 `true` 로 변경해준다.

```swift
AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
            
    switch response.result {
    case .success(let data):
          print("성공, \(data)")
                
          let json = JSON(data)
          let result = json["message"].stringValue
                                
          if result == "login success" {
             // 로그인 성공 후 메인탭으로 전환
             guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
             guard let tab = window.rootViewController as? MainTabVC else { return }
             tab.isLogin = true
	     tab.checkLoginedUser()
                    
          } else {
             let alertSheet = UIAlertController(title: "알림",
                                                message: "로그인 실패",
                                                preferredStyle: .alert)
                    
              let okAction = UIAlertAction(title: "다시하기", style: .default)
                    
              alertSheet.addAction(okAction)
              self.present(alertSheet, animated: true, completion: nil)
          }
```

```swift
	// MainTabVC

	func checkLoginedUser() {        
        if isLogin == false {
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

https://user-images.githubusercontent.com/74236080/136214395-34d08d0b-a054-4785-b472-6b27048a84bd.mov

---

### 서버에서 발행하는 토큰 값 키체인에 저장

- 재사용을 위해 **`TokenUtils`** 클래스를 생성한 후에 작성
[TokenUtils](https://github.com/Netflix-Review/NetflixReview_iOS/blob/main/NetflixReview/Utils/TokenUtils.swift)

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

```swift
let tk = TokenUtils()
tk.create("\(url)", account: "accessToken", value: accessToken)
tk.create("\(url)", account: "username", value: username)
```
3. 로그인을 성공하면 메인탭으로 전환한다.

```swift
if result == "login success" {
    guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
    guard let tab = window.rootViewController as? MainTabVC else { return }
    tab.checkLoginedUser()
}
```

메인탭에서 checkLoginedUser() 메서드를 통해 해당 사용자의 토큰을 불러와서, 해당 토큰 값이 있으면 다시 앱을 실행할 때, 로그인페이지가 아닌 메인페이지를 로드한다.

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
