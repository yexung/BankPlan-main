//
//  SettingVC.swift
//  BankPlan
//
//  Created by 윤예성 on 5/30/24.
//

import UIKit
import AuthenticationServices
import FirebaseAuth

class SettingVC: UIViewController {

    @IBOutlet weak var DeleteAccountBtn: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    
    @IBAction func TapDeleteAccountBtn(_ sender: Any) {
        let user = Auth.auth().currentUser

        user?.delete { error in
            if let error = error {
                print("Error deleting user: \(error.localizedDescription)")
                // 에러 핸들링 (예: 사용자에게 에러 메시지 표시)
            } else {
                print("Successfully deleted user")
                // 로그아웃 및 로그인 화면으로 이동 등의 추가 동작을 여기에 구현
                UIManager.shared.viewChangeEvent(.MainLoginVC, nil)
            }
        }
    }
    
    @IBAction func dismissBtnClick(_ sender: Any) {
        UIManager.shared.dismiss(self, nil, false)
    }
    
    @IBAction func logOutBtnClick(_ sender: Any) {
        handleLogout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func handleLogout() {
        // Firebase 로그아웃
        do {
            try Auth.auth().signOut()
            print("Successfully logged out from Firebase")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        // 애플 로그인 상태 해제
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let userID = UserDefaults.standard.string(forKey: "appleAuthorizedUserIDKey") ?? ""
        appleIDProvider.getCredentialState(forUserID: userID) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is still valid. Show a message to the user.
                print("Apple ID is still authorized")
                break
            case .revoked:
                // The Apple ID credential is revoked. Handle the error.
                print("Apple ID is revoked")
                break
            case .notFound:
                // The Apple ID credential is not found. Show a message to the user.
                print("Apple ID not found")
                break
            default:
                break
            }
        }
        
        // 로그인 화면으로 이동하는 등의 추가 동작을 여기에 구현
        UIManager.shared.viewChangeEvent(.MainLoginVC, nil)
    }
}

