//
//  PinMoneyVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/19/24.
//

import UIKit

class PinMoneyVC: UIViewController {

    @IBOutlet weak var Dismiss: UIButton!
    

    @IBAction func TapDismiss(_ sender: Any) {
        UIManager.shared.dismiss(self, nil, false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
