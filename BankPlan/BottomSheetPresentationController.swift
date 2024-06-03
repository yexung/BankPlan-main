//
//  PresentationController.swift
//  BankPlan
//
//  Created by 윤예성 on 6/3/24.
//
import UIKit

class BottomSheetPresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height: CGFloat = 200
        return CGRect(x: 0, y: containerView.frame.height - height, width: containerView.frame.width, height: height)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.addSubview(presentedView!)
    }
}

