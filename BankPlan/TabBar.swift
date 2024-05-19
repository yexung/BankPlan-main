//
//  TabBar.swift
//  BankPlan
//
//  Created by 윤예성 on 4/28/24.
//

import UIKit

class TabBar: UITabBar {
    // Set your desired height here
    private let customHeight: CGFloat = 86

//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        var sizeThatFits = super.sizeThatFits(size)
//        if customHeight > sizeThatFits.height {
//            sizeThatFits.height = customHeight
//        }
//        return sizeThatFits
//    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var newFrame = self.frame
        //newFrame.size.height = customHeight
        //newFrame.origin.y = self.frame.origin.y + (self.frame.size.height - customHeight)
        self.frame = newFrame
        self.layer.cornerRadius = 20 // Set this to your desired value
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.masksToBounds = true

        // To adjust the position of the tab bar items, you might need to tweak them manually
        for view in self.subviews {
            var frame = view.frame
         //2   frame.origin.y = (customHeight - frame.size.height) / 2
            view.frame = frame
        }
    }
}
