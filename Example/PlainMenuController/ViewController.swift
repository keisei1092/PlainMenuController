//
//  ViewController.swift
//  PlainMenuController
//
//  Created by keisei_1092 on 12/03/2016.
//  Copyright (c) 2016 keisei_1092. All rights reserved.
//

import UIKit
import PlainMenuController

class ViewController: UIViewController {

    @IBAction func openFromLeftButtonTouchUpInside(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "MenuTableViewController", bundle: nil)
        let menuTableViewController = storyboard.instantiateInitialViewController() as! MenuTableViewController
        let navigationController = UINavigationController(rootViewController: menuTableViewController)
        navigationController.modalPresentationStyle = .custom
        navigationController.transitioningDelegate = self
        self.present(navigationController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MenuPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuPresentationAnimator(isPresentation: true)
    }

    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return MenuPresentationAnimator(isPresentation: false)
    }
}
