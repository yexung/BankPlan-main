//
//  MainLoginVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/3/24.
//

import UIKit
import AuthenticationServices // Apple 로그인 관련 라이브러리를 포함합니다.
import CryptoKit // 해시 함수 사용을 위한 라이브러리를 포함합니다.
import Firebase // Firebase 인증을 사용하기 위한 라이브러리를 포함합니다.

class MainLoginVC: UIViewController {
    
    // 로그인 버튼에 대한 아웃렛 변수들입니다.
    @IBOutlet weak var KakaoLoginBtn: UIButton!
    @IBOutlet weak var AppleLoginBtn: UIButton!
    @IBOutlet weak var GoogleLoginBtn: UIButton!
    @IBOutlet weak var FacebookLoginBtn: UIButton!
    
    private var currentNonce: String? // 현재 세션의 nonce 값을 저장할 변수입니다.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 사용자의 로그인 상태를 확인하고 적절한 화면으로 이동합니다.
        checkLoggedInState()
        
        // 사용자 로그인 상태 변화를 감지하여 로그를 출력합니다.
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                NSLog("사용자 정보 - UID: \(user.uid), 이메일: \(user.email ?? "이메일 없음")")
            } else {
                NSLog("로그인된 사용자 없음.")
            }
        }
    }
    
    // 사용자 로그인 상태를 확인하고 적절한 액션을 수행하는 메소드입니다.
    func checkLoggedInState() {
        if Auth.auth().currentUser != nil {
            // 이미 로그인 되어 있으면 MainVC로 이동합니다.
            UIManager.shared.viewChangeEvent(.TabBarVC, nil)
        } else {
            // 로그인 되어 있지 않으면 로그인 화면 유지합니다.
            NSLog("사용자 로그인 안됨, 로그인 화면 유지.")
        }
    }
    
//    // MainVC로의 화면 전환을 처리하는 메소드입니다.
//    func transitionToMainVC() {
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "toMainVC", sender: self)
//        }
//    }
//    
//    // RegisterVC로의 화면 전환을 처리하는 메소드입니다.
//    func transitionToRegisterVC() {
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "toRegisterVC", sender: self)
//        }
//    }
    
    // Apple 로그인 버튼 클릭 시 실행되는 액션입니다.
    @IBAction func AppleLoginBtnTouchDown(_ sender: Any) {
        startSignInWithAppleFlow() // Apple 로그인 프로세스를 시작합니다.
    }
}

// Apple 로그인 관련 메소드를 포함한 확장입니다.
extension MainLoginVC {
    
    // Apple 로그인 프로세스를 시작하는 메소드입니다.
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString() // nonce를 생성합니다.
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] // 요청할 사용자 정보 스코프입니다.
        request.nonce = sha256(nonce) // 생성된 nonce를 SHA256으로 해시 처리합니다.
        
        // 인증 요청을 처리할 컨트롤러를 생성합니다.
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 입력된 문자열을 SHA256 해시로 변환하는 메소드입니다.
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // 무작위 nonce 문자열을 생성하는 메소드입니다.
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Nonce 생성 실패. SecRandomCopyBytes 실패, OSStatus \(errorCode)")
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

// ASAuthorizationControllerDelegate 프로토콜을 준수하는 확장입니다.
extension MainLoginVC: ASAuthorizationControllerDelegate {
    
    // 권한 부여가 완료된 후 호출되는 메소드입니다.
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("상태 오류: 로그인 콜백을 받았지만 요청된 로그인이 없습니다.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Identity 토큰을 가져올 수 없습니다.")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("토큰 문자열을 직렬화할 수 없습니다: \(appleIDToken.debugDescription)")
                return
            }
            
            // 제공자 ID, idToken, nonce를 사용해 Firebase 자격 증명을 생성합니다.
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            // Firebase로 로그인을 시도합니다.
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Apple 로그인 오류: \(error)")
                    return
                }
                
                // 로그인 성공 후 새 사용자 여부에 따라 적절한 화면으로 전환합니다.
                if let newUser = authResult?.additionalUserInfo?.isNewUser, newUser {
                    UIManager.shared.viewChangeEvent(.RegisterVC, nil) // 새 사용자는 등록 화면으로
                } else {
                    UIManager.shared.viewChangeEvent(.TabBarVC, nil)
                }
            }
        }
    }
}

// ASAuthorizationControllerPresentationContextProviding 프로토콜을 준수하는 확장입니다.
extension MainLoginVC : ASAuthorizationControllerPresentationContextProviding {
    // 인증 컨트롤러의 프레젠테이션 앵커를 제공하는 메소드입니다.
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
