//
//  ExchangeRateVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/22/24.
//

import UIKit
import Foundation

struct ExchangeInfo {
    let currencyCode: String
    let exchangeRate: Double
    let riseRate: Double
}

class ExchangeRateCell: UITableViewCell {
    @IBOutlet weak var CurrencyCodeText: UILabel!
    @IBOutlet weak var ExchangeRateText: UILabel!
    @IBOutlet weak var RiseRateText: UILabel!
    @IBOutlet weak var CellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        CellView.layer.cornerRadius = 12
        CellView.layer.masksToBounds = true
        // Optionally, set a border to see the rounded corners clearly
//        contentView.layer.borderWidth = 1.0
//        contentView.layer.borderColor = UIColor.lightGray.cgColor
//        // Set the background color to clear
//        backgroundColor = .yellow
    }
}

class ExchangeRateVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var ExchangeRateTableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var Time: UILabel!

    var ExchangeRateData: [ExchangeInfo] = [
        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1),
        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1),
        ExchangeInfo(currencyCode: "USD", exchangeRate: 1401.05, riseRate: 2.1)
    ]
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        ExchangeRateTableView.delegate = self
        ExchangeRateTableView.dataSource = self

        // Initialize and start the timer
        startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Invalidate the timer when the view is about to disappear
        timer?.invalidate()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
    }

    @objc func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        Time.text = "오늘 \(formatter.string(from: Date())) 기준"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExchangeRateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateCell", for: indexPath) as? ExchangeRateCell else {
            return UITableViewCell()
        }
        
        let ExchangeRate = ExchangeRateData[indexPath.row]
        cell.CurrencyCodeText.text = ExchangeRate.currencyCode
        cell.ExchangeRateText.text = "\(ExchangeRate.exchangeRate)"
        cell.RiseRateText.text = "\(ExchangeRate.riseRate)%"
        
        return cell
    }

    @IBAction func tapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
}
