//
//  ExchangeRateVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/22/24.
//

import UIKit

struct CurrencyInfo {
    let currencyCode: String
    let exchangeRate: Double
    let riseRate: Double
}

// 클래스 이름을 'CurrencyCell'로 유지
class CurrencyCell: UITableViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
}

class ExchangeRateVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var exchangeRateTableView: UITableView!
    
    var currencyData: [CurrencyInfo] = [
        CurrencyInfo(currencyCode: "USD", exchangeRate: 1400.12, riseRate: 0.1),
        CurrencyInfo(currencyCode: "EUR", exchangeRate: 1520.55, riseRate: 0.2),
        CurrencyInfo(currencyCode: "JPY", exchangeRate: 13.07, riseRate: 0.05)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeRateTableView.delegate = self
        exchangeRateTableView.dataSource = self
       exchangeRateTableView.rowHeight = UITableView.automaticDimension
        exchangeRateTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        
        let currency = currencyData[indexPath.row]
        cell.mainLabel.text = "\(currency.exchangeRate)"
        cell.detailLabel.text = "\(currency.riseRate)%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
