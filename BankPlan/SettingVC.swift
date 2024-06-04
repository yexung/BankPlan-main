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
    
    let bottomSheetTransitioningDelegate = BottomSheetTransitioningDelegate()
    
    @IBAction func TapDeleteAccountBtn(_ sender: Any) {
        presentBottomSheet(title: "탈퇴",
                           message: "정말로 계정을 삭제하시겠습니까? 삭제하시면 되돌릴 수 없습니다.",
                           buttonText: "탈퇴하기",
                           buttonAction: { [weak self] in self?.deleteAccount() })
    }
    
    @IBAction func dismissBtnClick(_ sender: Any) {
        UIManager.shared.dismiss(self, nil, false)
    }
    
    @IBAction func logOutBtnClick(_ sender: Any) {
        presentBottomSheet(title: "로그아웃",
                           message: "정말로 로그아웃하시겠습니까?",
                           buttonText: "로그아웃하기",
                           buttonAction: { [weak self] in self?.handleLogout() })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func presentBottomSheet(title: String, message: String, buttonText: String, buttonAction: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let bottomSheetVC = storyboard.instantiateViewController(withIdentifier: "BottomSheetVC") as? BottomSheetVC {
            bottomSheetVC.titleText = title
            bottomSheetVC.messageText = message
            bottomSheetVC.buttonText = buttonText
            bottomSheetVC.buttonAction = buttonAction
            bottomSheetVC.modalPresentationStyle = .custom
            bottomSheetVC.transitioningDelegate = bottomSheetTransitioningDelegate
            present(bottomSheetVC, animated: true, completion: nil)
        }
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        if let user = Auth.auth().currentUser {
            NSLog("User UID: \(user.uid)")
        } else {
            NSLog("No user is currently logged in.")
        }
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

    func handleLogout() {
        // Firebase 로그아웃
        if let user = Auth.auth().currentUser {
            NSLog("User UID: \(user.uid)")
        } else {
            NSLog("No user is currently logged in.")
        }

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
