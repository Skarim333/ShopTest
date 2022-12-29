//
//  BasketModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 29.08.2022.
//

import Foundation

struct Cart: Decodable {
    let basket: [Basket]
    let delivery: String
    let id: String
    let total: Int
}

struct Basket: Decodable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
