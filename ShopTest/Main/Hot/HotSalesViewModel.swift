//
//  HotSalesViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import UIKit
import Kingfisher

protocol HotSalesCollectionCellViewModelProtocol {
    init(model: HomeStore)
    var isNew: Bool { get }
    var isBuy: Bool { get }
    var brand: String { get }
    var desctiption: String { get }
    var image: String { get }
    
    var viewImageData: ((String)->Void)? { get set }
}

class HotSalesCollectionCellViewModel: HotSalesCollectionCellViewModelProtocol {
    
    private let model: HomeStore
    
    required init(model: HomeStore) {
        self.model = model
    }
    
    var isNew: Bool {
        model.isNew ?? false
    }
    
    var isBuy: Bool {
        model.isBuy
    }
    
    var brand: String {
        model.title
    }
    
    var desctiption: String {
        model.subtitle
    }
    
    var image: String {
        model.picture
    }
    
    var viewImageData: ((String)->Void)?
}
