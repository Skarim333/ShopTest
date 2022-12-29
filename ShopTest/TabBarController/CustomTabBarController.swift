//
//  CustomTabBarController.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.layer.cornerRadius = 30
        let barAppearance = UITabBarAppearance()
        barAppearance.backgroundColor = .mainBlue()
        tabBar.standardAppearance = barAppearance
        tabBar.scrollEdgeAppearance = barAppearance
        tabBar.frame = CGRect(x: 0, y: view.height - 72, width: view.width, height: 72)
    }
    
    override func viewDidLoad() {
        tabBar.clipsToBounds = true
        tabBar.itemWidth = 50
        tabBar.itemSpacing = 40
        tabBar.itemPositioning = .centered
    }

    private func annimationsWhenSelectedItem(_ item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.2
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }

        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }

    func createTabBarItem(withImage image: UIImage?, tag: Int) -> UITabBarItem {
        tabBarItem = UITabBarItem.init(title: "",
                                       image: image,
                                       tag: tag)
        
        tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: -20, right: 0)
        return tabBarItem
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.annimationsWhenSelectedItem(item)
    }
}
