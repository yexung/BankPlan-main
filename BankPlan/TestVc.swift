//
//  TestVc.swift
//  BankPlan
//
//  Created by 윤예성 on 5/24/24.
//

import UIKit
import Alamofire

struct ExchangeRateInfo: Codable {
    let curUnit: String
    let dealBASR: String

    enum CodingKeys: String, CodingKey {
        case curUnit = "cur_unit"
        case dealBASR = "deal_bas_r"
    }
}

class TestVc: UIViewController {
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                fetchExchangeRateData()
    }
    
        func fetchExchangeRateData() {
            let url = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=mlUixFu3ldgyyddDiD5uSCZ6MvigAlhj&searchdate=20180102&data=AP01"
    
            AF.request(url).responseDecodable(of: [ExchangeRateInfo].self) { response in
                switch response.result {
                case .success(let data):
                    
                    for one in data {
                        
                        NSLog( " \( one.curUnit ) "  )
                        
                    }
                    
                    if let firstExchangeRate = data.first {
                        DispatchQueue.main.async {
                            self.currencyCodeLabel.text = "Currency Code: \(firstExchangeRate.curUnit)"
                            self.exchangeRateLabel.text = "Exchange Rate: \(firstExchangeRate.dealBASR)"
                        }
                    }
                    
                    
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
}
