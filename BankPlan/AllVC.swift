//
//  AllVC.swift
//  BankPlan
//
//  Created by 윤예성 on 5/25/24.
//

import UIKit

class AllVC: UIViewController {

    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var SettingBtn: UIButton!
    
    @IBAction func SettingBtnClick(_ sender: Any) {
        UIManager.shared.viewChangeEvent(.SettingVC, nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileView.layer.cornerRadius = 12
        ProfileView.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
}
