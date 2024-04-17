//
//  RegisterSuccess.swift
//  BankPlan
//
//  Created by 윤예성 on 4/15/24.
//

import UIKit

class RegisterSuccess: UIViewController {

    @IBOutlet weak var SuccessBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SuccessBtn.layer.cornerRadius = 12
        SuccessBtn.layer.masksToBounds = true

    }
}
