//
//  MenuPresentationController.swift
//  Pods
//
//  Created by keisei_1092 on 2016/12/03.
//
//

import UIKit

open class MenuPresentationController: UIPresentationController {

    open var overlay: UIView!

    open override func presentationTransitionWillBegin() {
        let containerView = self.containerView!

        self.overlay = UIView(frame: containerView.bounds)
        self.overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(self.overlayDidTouch(sender:)))]
        self.overlay.backgroundColor = UIColor.black
        self.overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, at: 0)

        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            [unowned self] context in
            self.overlay.alpha = 0.5
            }, completion: nil)
    }

    open override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            [unowned self] context in
            self.overlay.alpha = 0.0
            }, completion: nil)
    }

    open override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }

    open func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * 0.75, height: parentSize.height)
    }

    open override var frameOfPresentedViewInContainerView: CGRect {
        get {
            var presentedViewFrame = CGRect.zero
            let containerBounds = containerView!.bounds
            presentedViewFrame.size = self.sizeForChildContentContainer(container: self.presentedViewController, withParentContainerSize: containerBounds.size)
            presentedViewFrame.origin.x = 0
            presentedViewFrame.origin.y = containerBounds.size.height - presentedViewFrame.size.height
            return presentedViewFrame
        }
    }

    open override func containerViewWillLayoutSubviews() {
        overlay.frame = containerView!.bounds
        self.presentedView!.frame = self.frameOfPresentedViewInContainerView
    }

    open override func containerViewDidLayoutSubviews() {
    }

    open func overlayDidTouch(sender: AnyObject) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
