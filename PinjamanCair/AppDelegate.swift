//
//  AppDelegate.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNotificationObserver()
        setupRootViewController()
        return true
    }
    
    private func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
    }
}

// MARK: - Notification Handling
extension AppDelegate {
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRootViewControllerChange),
            name: .changeRootViewController,
            object: nil
        )
    }
    
    @objc private func handleRootViewControllerChange() {
        window?.rootViewController = AppTabBarController()
    }
}

// MARK: - Notification Names Extension
extension Notification.Name {
    static let changeRootViewController = Notification.Name("changeRootViewController")
}
