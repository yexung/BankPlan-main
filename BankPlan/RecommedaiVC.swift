////
////  RecommedaiVC.swift
////  BankPlan
////
////  Created by 윤예성 on 4/27/24.
////
//
//import UIKit
//struct RecommedInfo {
//    let StockName: String
//    let StockCode: Int
//    let Price: String
//    let RiseRate: Double
//}
//class RecommedaiVC: UIViewController {
//    
//
//   
//    
//
//    @IBOutlet weak var RecommedTableViewCell: UITableViewCell!
//    @IBOutlet weak var RecommedTableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//
//}
//
//
// 
//class RecommedCell: UITableViewCell {
//    @IBOutlet weak var StockCode: UILabel!
//    @IBOutlet weak var StockName: UILabel!
//    @IBOutlet weak var RiseRate: UILabel!
//    @IBOutlet weak var Price: UILabel!
//    @IBOutlet weak var MarketOdds: UILabel!
//    @IBOutlet weak var MarketOddsRiseRate: UILabel!
//    
//}
////
////class ExchangeRateVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
////    @IBOutlet weak var ExchangeRateTableView: UITableView!
////    @IBOutlet weak var dismissButton: UIButton!
////
////    var ExchangeRateData: [ExchangeInfo] = [
////        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1),
////        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1),
////        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1)
////    ]
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        ExchangeRateTableView.delegate = self
////        ExchangeRateTableView.dataSource = self
////    }
////    
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return ExchangeRateData.count
////    }
////    
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateCell", for: indexPath) as? ExchangeRateCell else {
////            return UITableViewCell()
////        }
////        
////        let ExchangeRate = ExchangeRateData[indexPath.row]
////        cell.CurrencyCodeText.text = "\(ExchangeRate.currencyCode)"
////        cell.ExchangeRateText.text = "\(ExchangeRate.exchangeRate)"
////        cell.RiseRateText.text = "\(ExchangeRate.riseRate)%"
////        
////        return cell
////    }
////
////    @IBAction func tapDismiss(_ sender: Any) {
////        self.dismiss(animated: true, completion: nil)
////    }
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 70
////    }
////}
////
