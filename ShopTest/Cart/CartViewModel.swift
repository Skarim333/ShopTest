//
//  CartViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import Foundation

protocol CartViewModelProtocol {
    var basket: [Basket] { get }
    var total: String { get }
    var delivery: String { get }
    var basketCount: Int { get }
    var numberOfBasket: Int { get }
    var didLoadDataForCart: ((Bool) -> Void)? { get set }
    func getCartViewModel(at index: Int) -> CartViewCellViewModelProtocol
    var updateViews: ((CartViewModelProtocol) -> Void)? { get set }
}

class CartViewModel: CartViewModelProtocol {

    var coordinator: CartCoordinator?
    private var cartData: Cart?
    private var didLoadCartData: ((Bool) -> Void)?
    var productCount = 1
    var dictPrice = [1: 1500, 2: 1800]
    var dictCount = [1: 1, 2: 1]
    
    required init() {
        loadData()
    }
    
    var basket: [Basket] {
        return cartData?.basket ?? []
    }
    
    var total: String {
        let total = dictPrice.values.reduce(0, +)
        return "\(String.convertNumberInPrice(for: total as NSNumber)) us"
    }
    
    var numberOfBasket: Int {
        productCount
    }
    
    var delivery: String {
        return cartData?.delivery ?? ""
    }
    
    var basketCount: Int {
        return dictCount.values.reduce(0, +)
    }
    
    var newPrice: Int {
        return 1
    }
    
    private func loadData() {
        APICaller.shared.getCart(completion: { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.cartData = data
                    self?.didLoadDataForCart?(true)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    var didLoadDataForCart: ((Bool) -> Void)? {
        get { didLoadCartData }
        set { didLoadCartData = newValue }
    }
    
    var updateViews: ((CartViewModelProtocol) -> Void)?
    
    func getCartViewModel(at index: Int) -> CartViewCellViewModelProtocol {
        let cellViewModel = CartViewCellViewModel(basket[index])
        cellViewModel.delegate = self
        return cellViewModel
    }                             
}

extension CartViewModel: CartTableCellViewModelDelegate {
    func didChangeCountProduct(_ productId: Int, newCount: Int) {
        guard let index = basket.firstIndex(where: { $0.id == productId }) else { return }
        let product = basket[index]
        productCount = newCount
        dictPrice.updateValue(productCount * product.price, forKey: product.id)
        dictCount.updateValue(productCount, forKey: product.id)
        updateViews?(self)
    }
}
