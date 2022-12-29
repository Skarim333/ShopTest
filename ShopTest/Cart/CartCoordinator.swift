//
//  BasketCoordinator.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import UIKit

final class CartCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: TabBarController?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cartViewController = CartViewController()
        let cartViewModel = CartViewModel()
        cartViewModel.coordinator = self
        cartViewController.viewModel = cartViewModel
        navigationController.setViewControllers([cartViewController], animated: true)
    }
}
