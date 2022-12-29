//
//  CategoryViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import Foundation

protocol CategoryCollectionCellViewModelProtocol: AnyObject {
    var nameCategory: String { get }
    var nameIconCategory: String { get }
    var isSelectCell: Bool { get }
    
    init(_ product: CategoryProduct, isSelect: Bool)
    func didSelectedCell()
    var changedViewModel: ((CategoryCollectionCellViewModelProtocol) -> Void)? { get set }
    func cellViewModel(forIndexPath indexPath: IndexPath) -> [String]
}

class CategoryCollectionCellViewModel: CategoryCollectionCellViewModelProtocol {

    let images = ["iphone.homebutton", "desktopcomputer", "heart", "books.vertical", "headphones"]
    let names = ["Phones", "Computer", "Health", "Books", "Headphones"]
    private var isSelect: Bool
    private let product: CategoryProduct
    
    required init(_ product: CategoryProduct, isSelect: Bool) {
        self.product = product
        self.isSelect = isSelect
    }
    
    var isSelectCell: Bool {
        isSelect
    }
    
    func numberOfRowsInSection() -> Int {
        names.count
    }
    
    func didSelectedCell() {
        isSelect.toggle()
        changedViewModel?(self)
    }
    
    var nameCategory: String {
        product.name
    }
    
    var nameIconCategory: String {
        product.nameImage
    }
    
    var changedViewModel: ((CategoryCollectionCellViewModelProtocol) -> Void)?
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> [String] {
        let image = images[indexPath.row]
        let name = names[indexPath.row]
        return [image, name]
    }
}
