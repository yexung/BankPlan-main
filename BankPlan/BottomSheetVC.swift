//
//  BottomSheetViewController.swift
//  BankPlan
//
//  Created by 윤예성 on 6/3/24.
//

import UIKit

class BottomSheetVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    var titleText: String = ""
    var messageText: String = ""
    var buttonText: String = ""
    var buttonAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // view의 상단 양쪽에 radius를 24씩 적용
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        titleLabel.text = titleText
        messageLabel.text = messageText
        actionButton.setTitle(buttonText, for: .normal)
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    @objc func actionButtonTapped() {
        buttonAction?()
        dismiss(animated: true, completion: nil)
    }

    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preferredContentSize = CGSize(width: view.frame.width, height: 294)
    }
}
