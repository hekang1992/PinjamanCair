//
//  BaseNavigationController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        removeScreenEdgeGesture()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    private func setupNavigationBar() {
        navigationBar.isHidden = true
        navigationBar.isTranslucent = false
    }
    
    private func removeScreenEdgeGesture() {
        interactivePopGestureRecognizer?.isEnabled = false
        view.gestureRecognizers?.removeAll { gesture in
            gesture is UIScreenEdgePanGestureRecognizer
        }
    }
}
