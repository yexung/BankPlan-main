//
//  ExchangeRateVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/22/24.
//

import UIKit
import UIKit
import Foundation
import Alamofire

struct ExchangeRateInfo: Codable {
    let curUnit: String
    let dealBASR: String

    enum CodingKeys: String, CodingKey {
        case curUnit = "cur_unit"
        case dealBASR = "deal_bas_r"
    }
}

class ExchangeRateCell: UITableViewCell {
    @IBOutlet weak var CurrencyCodeText: UILabel!
    @IBOutlet weak var ExchangeRateText: UILabel!
    @IBOutlet weak var CellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        CellView.layer.cornerRadius = 12
        CellView.layer.masksToBounds = true
    }
}

class ExchangeRateVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var ExchangeRateTableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var Time: UILabel!

    var ExchangeRateData: [ExchangeRateInfo] = []

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        ExchangeRateTableView.delegate = self
        ExchangeRateTableView.dataSource = self
        fetchExchangeRateData()
        startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    func fetchExchangeRateData() {
        let url = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=mlUixFu3ldgyyddDiD5uSCZ6MvigAlhj&searchdate=20180102&data=AP01"

        AF.request(url).responseDecodable(of: [ExchangeRateInfo].self) { response in
            switch response.result {
            case .success(let data):
                self.ExchangeRateData = data
                DispatchQueue.main.async {
                    self.ExchangeRateTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
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

        let exchangeRate = ExchangeRateData[indexPath.row]
        cell.CurrencyCodeText.text = exchangeRate.curUnit
        cell.ExchangeRateText.text = exchangeRate.dealBASR

        return cell
    }

    @IBAction func tapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
}
