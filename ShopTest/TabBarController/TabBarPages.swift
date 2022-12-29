//
//  TabBarPages.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import UIKit

enum TabBarPages: String {
    case explorer
    case cart
    case favorite
    case profile
    
    func pageImageValue() -> UIImage {
        switch self {
        case .explorer:
            return #imageLiteral(resourceName: "explorerTab").withRenderingMode(.alwaysOriginal)
        case .cart:
            return #imageLiteral(resourceName: "cartTab").withRenderingMode(.alwaysOriginal)
        case .favorite:
            return #imageLiteral(resourceName: "favoriteTab").withRenderingMode(.alwaysOriginal)
        case .profile:
            return #imageLiteral(resourceName: "profileTab").withRenderingMode(.alwaysOriginal)
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .explorer:
            return 0
        case .cart:
            return 1
        case .favorite:
            return 2
        case .profile:
            return 3
        }
    }
}
