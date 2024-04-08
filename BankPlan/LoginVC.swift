//
//  LoginVC.swift
//  BankPlan
//
//  Created by 윤예성 on 3/31/24.
//

import UIKit
import Alamofire
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var idtextfield: UITextField!
    @IBOutlet weak var pwtextfield: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result.text = "asd"
        
        
        
        
        }
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { [self] auth, user in
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                result.text = (user.uid)
                let email = user.email
                let photoURL = user.photoURL
                var multiFactorString = "MultiFactor: "
                for info in user.multiFactor.enrolledFactors {
                    multiFactorString += info.displayName ?? "[DispayName]"
                    multiFactorString += " "
                }
            }
            }
    }
    @IBAction func buttonCheck() {
   
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        let parameters: [String: Any] = [
            "id":idtextfield.text ?? "",
            "passwd": pwtextfield.text ?? ""
        ]
        let url = "http://127.0.0.1:8080/LoginCheck" //?id=kl&passwd=jk
        
        
        Auth.auth().signIn(withEmail: idtextfield.text ?? "", password: pwtextfield.text ?? "") { [weak self] authResult, erroxr in
          guard let strongSelf = self else { return }
          // ...
        }
        
//        AF.request(url, method: .post , parameters: parameters, encoding: URLEncoding.default)
//            .responseJSON { [self] response in
//                switch response.result {
//                case .success(let value):
//                    print("Response JSON: \(value)")
//                    Auth.auth().createUser(withEmail: idtextfield.text ?? "", password: pwtextfield.text ?? "") { authResult, error in
//                        
//                       
//                      // ...
//                    }
//                    // Handle successful response here
//                case .failure(let error):
//                    print("Error: \(error)")
//                    // Handle error here
//                }
//            }
    }
}
