//
//  ProductCart.swift
//  ShopTest
//
//  Created by Карим Садыков on 27.11.2022.
//

import UIKit

struct ProductCart: Codable {
    let id: Int
    let name: String
    var count: Int
    let price: Int
    let image: String

}
