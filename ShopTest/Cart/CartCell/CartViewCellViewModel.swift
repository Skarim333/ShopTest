//
//  CartViewCellViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 24.12.2022.
//

import Foundation

protocol CartViewCellViewModelProtocol {
    var id: Int { get }
    var images: String { get }
    var price: Int { get }
    var title: String { get }
    var counterProduct: Int { get }
    func changePrice(_ newCount: Int)
    init(_ basket: Basket)
    
}

protocol CartTableCellViewModelDelegate: AnyObject {
    func didChangeCountProduct(_ productId: Int, newCount: Int)
}

class CartViewCellViewModel: CartViewCellViewModelProtocol {
    
    weak var delegate: CartTableCellViewModelDelegate?
    private var basket: Basket
    var counterProduct = 1
    
    required init(_ basket: Basket) {
        self.basket = basket
    }
    
    var id: Int {
        return basket.id
    }
    
    var images: String {
        return basket.images
    }
    
    var price: Int {
        return basket.price * counterProduct
    }
    
    var title: String {
        return basket.title
    }
    
    func changePrice(_ newCount: Int) {
        counterProduct = newCount
        delegate?.didChangeCountProduct(basket.id, newCount: newCount)
    }
    
}
