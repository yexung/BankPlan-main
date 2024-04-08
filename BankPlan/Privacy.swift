//
//  test.swift
//  BankPlan
//
//  Created by 윤예성 on 4/7/24.
//

import UIKit

class test: UIViewController {

    let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        // Set the unchecked image for the normal state
        button.setImage(UIImage(named: "Allagree"), for: .normal)
        // Set the checked image for the selected state
        button.setImage(UIImage(named: "AllagreeSuccess"), for: .selected)
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add the checkbox button to the view
        checkboxButton.frame = CGRect(x: 100, y: 100, width: 50, height: 50) // Adjust the frame as needed
        view.addSubview(checkboxButton)
    }
    
    @objc func toggleCheckbox() {
        checkboxButton.isSelected = !checkboxButton.isSelected
    }
}
