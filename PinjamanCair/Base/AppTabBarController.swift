//
//  AppTabBarController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshTabBarColors()
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hex: "#C5C5C5"),
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hex: "#247255"),
            .font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ]
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        
        appearance.stackedLayoutAppearance.normal.iconColor = .init(hex: "#C5C5C5")
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.init(hex: "#247255")
        
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 15.0, *) {
        } else {
            UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        }
        
        tabBar.tintColor = UIColor.init(hex: "#247255")
        tabBar.unselectedItemTintColor = .init(hex: "#C5C5C5")
    }
    
    private func refreshTabBarColors() {
        guard let items = tabBar.items else { return }
        
        for (index, item) in items.enumerated() {
            if index == selectedIndex {
                item.badgeColor = UIColor.init(hex: "#247255")
                if let selectedImage = item.selectedImage {
                    item.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
                }
            } else {
                if let image = item.image {
                    item.image = image.withRenderingMode(.alwaysOriginal)
                }
            }
        }
    }
    
    private func setupViewControllers() {
        viewControllers = [
            createNavigationController(
                for: HomeViewController(),
                title: "Loan".localized,
                image: "loan_nor_image",
                selectedImage: "loan_sel_image"
            ),
            createNavigationController(
                for: OrderViewController(),
                title: "Order".localized,
                image: "order_nor_image",
                selectedImage: "order_sel_image"
            ),
            createNavigationController(
                for: AccountViewController(),
                title: "Account".localized,
                image: "mine_nor_image",
                selectedImage: "mine_sel_image"
            )
        ]
    }
    
    private func createNavigationController(
        for rootViewController: UIViewController,
        title: String,
        image: String,
        selectedImage: String
    ) -> UINavigationController {
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        
        let normalImg = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        let selectedImg = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        let tabBarItem = UITabBarItem(
            title: title,
            image: normalImg,
            selectedImage: selectedImg
        )
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hex: "#C5C5C5"),
            .font: UIFont.systemFont(ofSize: 11)
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hex: "#247255"),
            .font: UIFont.systemFont(ofSize: 11, weight: .medium)
        ]
        tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        rootViewController.tabBarItem = tabBarItem
        return navigationController
    }
}

extension UIColor {

    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
