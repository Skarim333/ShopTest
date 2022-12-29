//
//  ImageViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 22.12.2022.
//

import Foundation

protocol ImageViewCellViewModelProtocol {
    var image: String { get }
    init(_ image: String)
    
}

class ImageViewCellViewModel: ImageViewCellViewModelProtocol {
    
    var image: String
    
    required init(_ image: String) {
        self.image = image
    }
}
