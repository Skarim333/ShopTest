//
//  DetailsModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 29.08.2022.
//

import Foundation

struct Details: Decodable {
    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd: String
    let ssd: String
    let title: String
}
