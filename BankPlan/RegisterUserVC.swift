//
//  RegisterUserVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/10/24.
//

import UIKit
import Alamofire
import Firebase

class RegisterUserVC: UIViewController {
    
    
    @IBOutlet weak var DismissBtn: UIButton!
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var NextBtn: UIButton!
    
    @IBOutlet weak var NameView: UIView!
    
    var NextGoCnt: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NameView.layer.cornerRadius = 8
        NameView.layer.masksToBounds = true
        NameView.layer.borderWidth = 4
        
        NextBtn.layer.cornerRadius = 12
        NextBtn.layer.masksToBounds = true
        Auth.auth().addStateDidChangeListener { auth, user in
            NSLog("user inof   " + user!.uid  + " : " + user!.email! + " : " );
            
        }
        updateNextButtonState()
        
        // 텍스트 필드의 편집 변화를 감지하는 옵저버 추가
        UserNameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
           
           // 텍스트 필드의 편집이 변경되었을 때 호출되는 메서드
    @objc func textFieldDidChange(_ textField: UITextField) {
        // 입력된 텍스트의 존재 여부에 따라 버튼 상태 업데이트
        updateNextButtonState()
    }
           
           // 다음 버튼 상태 업데이트 메서드
    func updateNextButtonState() {
        // 텍스트 필드에 값이 있는지 확인하여 버튼 상태 업데이트
        let isTextFieldEmpty = UserNameText.text?.isEmpty ?? true
        NextBtn.isSelected = !isTextFieldEmpty
        if NextBtn.isSelected {
            NextBtn.backgroundColor = UIColor.primary50
            NameView.layer.borderColor = UIColor.primary50.cgColor
        } else {
            NextBtn.backgroundColor = UIColor.neutral90
            NameView.layer.borderColor = UIColor.neutral80.cgColor
        }
    }

    @IBAction func TapDismissBtn(_ sender: Any) {
        UIManager.shared.dismiss(self, nil, false)
    }
    @IBAction func TapNextBtn(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            let parameters: [String: Any] = [
                "id": UserNameText.text ?? "",
                "uid": user.uid,
                "email": user.email ?? ""
            ]
            let url = "http://127.0.0.1:8080/register1"
            
            AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
                .validate(statusCode: 200..<300) // 200 ~ 299 사이의 상태 코드를 유효한 것으로 간주
                .responseData { response in
                    switch response.result {
                    case .success(_):
                        print("요청 성공")
                        
                        // 요청이 성공하였으나, 서버에서 응답을 보내지 않는 경우
                        // 여기에 필요한 작업을 추가하세요.
                    case .failure(let error):
                        print("Error: \(error)")
                        // 요청이 실패한 경우
                        // 여기에 필요한 작업을 추가하세요.
                    }
                }
        }
       
    }
//    func NextBtnView(){
//        if  {
//            NextBtn.isSelected = true
//            NextBtn.backgroundColor = .primary50
//        }else {
//            NextBtn.isSelected = false
//            NextBtn.backgroundColor = .neutral90
//        }
//        
//        
//    }

}
