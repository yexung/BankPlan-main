//
//  RegisterVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/5/24.
//

import UIKit

class RegisterVC: UIViewController {
    var allAgree = false
    var PrivacyAgree = false
    var MarketingAgree = false
    var AgreeCnt: Int = 0
    
    
    @IBOutlet weak var MarketingAgreeBtn: UIButton!
    @IBOutlet weak var PrivacyAgreeBtn: UIButton!
    @IBOutlet weak var AllagreeBtn: UIButton!
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var PrivacyViewBtn: UIButton!
    
    @IBAction func TapAll(_ sender: UIButton) {
    }
    @IBAction func TapPrivacy(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AllagreeBtn.addTarget(self, action: #selector(TapAllagree(_:)), for: .touchUpInside)
        PrivacyAgreeBtn.addTarget(self, action: #selector(TapPrivacyagree(_:)), for: .touchUpInside)
        MarketingAgreeBtn.addTarget(self, action: #selector(TapMarketing(_:)), for: .touchUpInside)
        
        ///
        AllagreeBtn.isSelected = false
        PrivacyAgreeBtn.isSelected = false
        MarketingAgreeBtn.isSelected = false
        NextBtn.isSelected = false
        
    }

    
    
    @objc func TapAllagree(_ sender: UIButton) {
        // Toggle selected state when button is clicked
        sender.isSelected = !sender.isSelected
        
        // You can perform additional actions based on the selected state here
        if sender.isSelected {
            print("Button is selected")
            PrivacyAgreeBtn.isSelected = true
            MarketingAgreeBtn.isSelected = true
            AgreeCnt = 2
            
            
        } else {
            print("Button is not selected")
            PrivacyAgreeBtn.isSelected = false
            MarketingAgreeBtn.isSelected = false
            AgreeCnt = 0
        }
        CheckAllagree()
        NextBtnView()
    }
    @objc func TapPrivacyagree(_ sender: UIButton) {
        // Toggle selected state when button is clicked
        sender.isSelected = !sender.isSelected
        
        // You can perform additional actions based on the selected state here
        if sender.isSelected {
            print("Button is selected")
            AgreeCnt += 1
            
        } else {
            print("Button is not selected")
            AgreeCnt -= 1
        }
        CheckAllagree()
        NextBtnView()
    }
    @objc func TapMarketing(_ sender: UIButton) {
        // Toggle selected state when button is clicked
        sender.isSelected = !sender.isSelected
        
        // You can perform additional actions based on the selected state here
        if sender.isSelected {
            print("Button is selected")
            AgreeCnt += 1
        } else {
            print("Button is not selected")
            AgreeCnt -= 1
        }
        CheckAllagree()
        NextBtnView()
        
    }
    func CheckAllagree(){
        if (AgreeCnt == 2){
            AllagreeBtn.isSelected = true
        } else {
            AllagreeBtn.isSelected = false
        }
    }
    func NextBtnView(){
        if AllagreeBtn.isSelected == true || PrivacyAgreeBtn.isSelected == true {
            NextBtn.isSelected = true
            NextBtn.backgroundColor = .primary50
        }else {
            NextBtn.isSelected = false
            NextBtn.backgroundColor = .neutral90
        }
        
        
    }
    
    
    
}
