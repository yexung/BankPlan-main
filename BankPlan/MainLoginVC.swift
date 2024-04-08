//
//  MainLoginVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/3/24.
//

import UIKit
import AuthenticationServices // Apple 로그인 관련 라이브러리
import CryptoKit // 해시 값 추가
import Firebase

class MainLoginVC: UIViewController{
    
    // 로그인 버튼에 대한 아웃렛
    @IBOutlet weak var KakaoLoginBtn: UIButton!
    @IBOutlet weak var AppleLoginBtn: UIButton!
    @IBOutlet weak var GoogleLoginBtn: UIButton!
    @IBOutlet weak var FacebookLoginBtn: UIButton!
    
    private var currentNonce: String? // nonce를 저장하기 위한 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Auth.auth().addStateDidChangeListener { auth, user in
            NSLog("user inof   " + user!.uid  + " : " + user!.email! + " : " );
       }

        
        

    }
    
    // Apple 로그인 버튼이 눌렸을 때 실행되는 액션
    @IBAction func AppleLoginBtnTouchDown(_ sender: Any) {
        startSignInWithAppleFlow() // Apple 로그인 플로우 시작
    }
}

// MainLoginVC의 확장
extension MainLoginVC {
    
    // Sign In with Apple 플로우를 시작하는 함수
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString() // 무작위 nonce 생성
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] // 사용자 정보를 위한 요청된 스코프
        request.nonce = sha256(nonce) // 요청에 nonce 설정
        
        // 요청을 위한 인증 컨트롤러 생성
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 문자열의 SHA256 해시를 계산하는 함수
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // 무작위 nonce 문자열을 생성하는 함수
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

// ASAuthorizationControllerDelegate를 위한 MainLoginVC의 확장
extension MainLoginVC: ASAuthorizationControllerDelegate {
    
    // 권한 부여가 완료되면 실행되는 콜백 함수
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // 제공자 ID, idToken 및 nonce로 자격 증명 생성
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            // 자격 증명을 사용하여 Firebase에 로그인
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
                // Firebase에서 Apple로 로그인 성공
                // 메인 화면으로 이동
            }
        }
    }
}

// ASAuthorizationControllerPresentationContextProviding을 위한 MainLoginVC의 확장
extension MainLoginVC : ASAuthorizationControllerPresentationContextProviding {
    // 인증 컨트롤러에 대한 프레젠테이션 앵커를 제공하는 함수
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
