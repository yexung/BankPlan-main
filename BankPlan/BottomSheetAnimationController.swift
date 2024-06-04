//
//  BottomSheetAnimationController.swift
//  BankPlan
//
//  Created by 윤예성 on 6/3/24.
//

import UIKit

class BottomSheetAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool

    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if let toViewController = transitionContext.viewController(forKey: .to),
           let toView = transitionContext.view(forKey: .to) {
            let finalFrame = CGRect(x: 0, y: containerView.frame.height - 250, width: containerView.frame.width, height: 250)

            if isPresenting {
                toView.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
                containerView.addSubview(toView)
            }

            let duration = transitionDuration(using: transitionContext)

            UIView.animate(withDuration: duration, animations: {
                if self.isPresenting {
                    toView.frame = finalFrame
                } else {
                    toView.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
                }
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
