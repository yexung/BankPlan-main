//
//  MainVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/14/24.
//

import UIKit

class MainVC: UIViewController {

    
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var PinMoneyView: UIView!
    @IBOutlet weak var DividendsCalendarView: UIView!
    @IBOutlet weak var ClosedDays: UIView!
    @IBOutlet weak var AdsView: UIView!
    @IBOutlet weak var NotificationBtn: UIButton!
    @IBOutlet weak var PinMoneyBtn: UIButton!
    @IBOutlet weak var DividendsCalendarBtn: UIButton!
    @IBOutlet weak var ClosedDaysBtn: UIButton!
    @IBOutlet weak var ExchangeRateBtn: UIButton!
    
    @IBAction func TapPinMoneyBtn(_ sender: Any) {
        UIManager.shared.viewChangeEvent(.PinMoneyVC, nil)
    }
    
    @IBAction func TapDividendsCalendar(_ sender: Any) {
        UIManager.shared.viewChangeEvent(.DividendsCalendarVC, nil)
        
    }
    @IBAction func TapClosedDays(_ sender: Any) {
        UIManager.shared.viewChangeEvent(.ClosedDays, nil)
    }
    @IBAction func TapNotification(_ sender: Any) {
        UIManager.shared.viewChangeEvent(.NotificationVC, nil)
    }
    @IBAction func TapExchangeBtn(_ sender: Any) {
        UIManager.shared.viewChangeEvent(.ExchangeRateVC, nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        SearchView.layer.cornerRadius = 12
        SearchView.layer.masksToBounds = true
        
        PinMoneyView.layer.cornerRadius = 12
        PinMoneyView.layer.masksToBounds = true
        DividendsCalendarView.layer.cornerRadius = 12
        DividendsCalendarView.layer.masksToBounds = true
        ClosedDays.layer.cornerRadius = 12
        ClosedDays.layer.masksToBounds = true
        AdsView.layer.cornerRadius = 12
        AdsView.layer.masksToBounds = true
        
        
    }

}
