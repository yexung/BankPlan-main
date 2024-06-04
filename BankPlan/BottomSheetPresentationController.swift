//
//  PresentationController.swift
//  BankPlan
//
//  Created by 윤예성 on 6/3/24.
//
import UIKit

class BottomSheetPresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        let safeAreaInsets = containerView.safeAreaInsets
        let frameHeight = containerView.frame.height - safeAreaInsets.bottom
        return CGRect(x: 0, y: frameHeight - 250, width: containerView.frame.width, height: 250)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        containerView.addSubview(presentedView!)
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedView?.removeFromSuperview()
    }
}
