//
//  TokenUtils.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/10/07.
//

import Security
import Alamofire
 
class TokenUtils {
    
    // Create
    // service 파라미터는 url주소를 의미
    func create(_ service: String, account: String, value: String) {
        
        // 1. query작성
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        // allowLossyConversion은 인코딩 과정에서 손실이 되는 것을 허용할 것인지 설정
        
        // 2. Delete
        // Key Chain은 Key값에 중복이 생기면 저장할 수 없기때문에 먼저 Delete
        SecItemDelete(keyChainQuery)
        
        // 3. Create
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "failed to saving Token")
    }
    
    // Read
    func read(_ service: String, account: String) -> String? {
        let KeyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue, // CFData타입으로 불러오라는 의미
            kSecMatchLimit: kSecMatchLimitOne // 중복되는 경우 하나의 값만 가져오라는 의미
        ]
        // CFData 타입 -> AnyObject로 받고, Data로 타입변환해서 사용하면됨
        
        // Read
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(KeyChainQuery, &dataTypeRef)
        
        // Read 성공 및 실패한 경우
        if(status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
    // Delete
    func delete(_ service: String, account: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
    
    // 키 체인에 저장된 값을 읽어옴
    func load(_ service: String, account: String) -> String? {
        // 키 체인 쿼리
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        // 키 체인에 저장된 값을 읽어옴
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        // 처리 결과가 성공이면 Data 타입으로 변환 - 다시 String 타입으로 변환
        if (status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else { // 실패면 nil 반환
            print("Nothing was retrieved from the ketchain. Status code \(status)")
            return nil
        }
    }
    
    // HTTPHeaders 구성
    // API에서 Authorization header를 필요로 하는경우에는 Header를 만들어서 REQ를 해야하는데, 이 메소드를 만들어 놓으면 간편
    
    func getAuthorizationHeader(serviceID: String) -> HTTPHeaders? {
        let serviceID = serviceID
        if let accessToken = self.read(serviceID, account: "accessToken") {
            return ["Authorization" : "bearer \(accessToken)"] as HTTPHeaders
        } else {
            return nil
        }
    }
}
 
