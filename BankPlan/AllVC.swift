//
//  AllVC.swift
//  BankPlan
//
//  Created by 윤예성 on 5/25/24.
//

import UIKit

class AllVC: UIViewController {

    @IBOutlet weak var ProfileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileView.layer.cornerRadius = 12
        ProfileView.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
}
