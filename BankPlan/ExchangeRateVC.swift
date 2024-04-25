//
//  ExchangeRateVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/22/24.
//

import UIKit
struct ExchangeInfo {
    let currencyCode: String
    let exchangeRate: Double
    let riseRate: Double
}

class ExchangeRateCell: UITableViewCell {
    @IBOutlet weak var CurrencyCodeText: UILabel!
    @IBOutlet weak var ExchangeRateText: UILabel!
    @IBOutlet weak var RiseRateText: UILabel!
}

class ExchangeRateVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var ExchangeRateTableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!

    var ExchangeRateData: [ExchangeInfo] = [
        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1),
        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1),
        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ExchangeRateTableView.delegate = self
        ExchangeRateTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExchangeRateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateCell", for: indexPath) as? ExchangeRateCell else {
            return UITableViewCell()
        }
        
        let ExchangeRate = ExchangeRateData[indexPath.row]
        cell.CurrencyCodeText.text = "\(ExchangeRate.currencyCode)"
        cell.ExchangeRateText.text = "\(ExchangeRate.exchangeRate)"
        cell.RiseRateText.text = "\(ExchangeRate.riseRate)%"
        
        return cell
    }

    @IBAction func tapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

