//
//  UIApplication+Extensions.swift
//  BankPlan
//
//  Created by 윤예성 on 4/14/24.
//

import Foundation
import UIKit

extension UIApplication {
class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = viewController as? UINavigationController {
        return topViewController(nav.visibleViewController)
    }
    if let tab = viewController as? UITabBarController {
        if let selected = tab.selectedViewController {
            return topViewController(selected)
        }
    }
    if let presented = viewController?.presentedViewController {
        return topViewController(presented)
    }
    return viewController
    }
}
