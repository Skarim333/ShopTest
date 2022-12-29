//
//  CategoryProduct.swift
//  ShopTest
//
//  Created by Карим Садыков on 20.12.2022.
//

import Foundation

enum CategoryProduct: String, CaseIterable {
    case Phones, Computer, Heart, Books, Other
    
    var name: String {
        switch self {
        case .Phones:
            return "Phone"
        case .Computer:
            return "Computer"
        case .Heart:
            return "Heart"
        case .Books:
            return "Books"
        case .Other:
            return "Other"
        }
    }
    
    var nameImage: String {
        switch self {
        case .Phones:
            return "iphone.homebutton"
        case .Computer:
            return "desktopcomputer"
        case .Heart:
            return "heart"
        case .Books:
            return "books.vertical"
        case .Other:
            return "headphones"
        }
    }
}
