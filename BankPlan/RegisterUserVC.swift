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
    
    
    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var TapNextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { auth, user in
            NSLog("user inof   " + user!.uid  + " : " + user!.email! + " : " );
       }
       
    }
    
    @IBAction func TapNextBtn(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            let parameters: [String: Any] = [
                "id": UserNameText.text ?? "",
                "hp": PhoneNumber.text ?? "",
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
}
