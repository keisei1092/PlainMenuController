//
//  MenuPresentationAnimator.swift
//  Pods
//
//  Created by keisei_1092 on 2016/12/03.
//
//

import UIKit

open class MenuPresentationAnimator: NSObject {

    open let isPresentation: Bool

    public init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }

}

extension MenuPresentationAnimator: UIViewControllerAnimatedTransitioning {
    open func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to
            : UITransitionContextViewControllerKey.from

        let controller = transitionContext.viewController(forKey: key)!

        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }

        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.x = -presentedFrame.width

        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame

        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
