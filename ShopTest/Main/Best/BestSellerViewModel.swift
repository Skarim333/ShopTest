//
//  BestSellerViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import Foundation

protocol BestSellerCollectionCellViewModelProtocol {
    var price: String { get }
    var discountPrice: String { get }
    var title: String { get }
    var isFavorite: Bool { get }
    var image: String { get }
    init(_ bestSeller: BestSeller)
    
    func didTouchFavorites()
    var changedViewModel: ((BestSellerCollectionCellViewModelProtocol) -> Void)? { get set }
}

class BestSellerCollectionCellViewModel: BestSellerCollectionCellViewModelProtocol {
    private let model: BestSeller
    private var isFavorites: Bool
    
    required init(_ bestSeller: BestSeller) {
        model = bestSeller
        isFavorites = model.isFavorites
    }
    
    var price: String {
        String.convertNumberInPrice(for: model.priceWithoutDiscount as NSNumber)
    }
    
    var discountPrice: String {
        String.convertNumberInPrice(for: model.discountPrice as NSNumber)
    }
    
    var title: String {
        model.title
    }
    
    var isFavorite: Bool {
        isFavorites
    }
    
    var image: String {
        model.picture
    }
    
    func didTouchFavorites() {
        isFavorites.toggle()
        changedViewModel?(self)
    }
    
    var changedViewModel: ((BestSellerCollectionCellViewModelProtocol) -> Void)?

}
