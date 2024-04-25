//
//  NotificationVC.swift
//  BankPlan
//
//  Created by 윤예성 on 4/19/24.
//

import UIKit

struct NotificationInfo {
    let detail: String
    let time: String
}

class NotificationCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}

class NotificationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!

    var notificationData: [NotificationInfo] = [
        NotificationInfo(detail: "SK하이닉스 신고가 돌파", time: "30분 전"),
        NotificationInfo(detail: "삼성전자 신고가 돌파", time: "45분 전"),
        NotificationInfo(detail: "네이버 신고가 돌파", time: "1시간 전")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else {
            return UITableViewCell()
        }
        
        let notification = notificationData[indexPath.row]
        cell.titleLabel.text = notification.detail
        cell.timeLabel.text = notification.time
        
        return cell
    }

    @IBAction func tapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
