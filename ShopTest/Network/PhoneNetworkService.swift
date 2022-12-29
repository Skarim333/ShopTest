//
//  PhoneNetwork .swift
//  ShopTest
//
//  Created by Карим Садыков on 22.11.2022.
//

import Foundation


final class APICaller {
    
    static let shared = APICaller()
    
    private enum ConstantUrl {
        static let main = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
        static let details = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
        static let cart = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    }
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getMain(completion: @escaping (Result<Phones, Error>) -> Void) {
        guard let url = URL(string: ConstantUrl.main) else {
            return completion(.failure(ErrorTypes.invalidURL))
        }
        let task = urlSession.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(Phones.self, from: data)
                completion(.success(results))
                
            } catch {
                completion(.failure(ErrorTypes.invalidMainData))
            }
        }
        task.resume()
    }
    
    func getDetails(completion: @escaping (Result<Details, Error>) -> Void) {
        guard let url = URL(string: ConstantUrl.details) else {
            return completion(.failure(ErrorTypes.invalidURL))
        }
        let task = urlSession.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(Details.self, from: data)
                completion(.success(results))
                
            } catch {
                completion(.failure(ErrorTypes.invalidMainData))
            }
        }
        task.resume()
    }
    
    func getCart(completion: @escaping (Result<Cart, Error>) -> Void) {
        guard let url = URL(string: ConstantUrl.cart) else {
            return completion(.failure(ErrorTypes.invalidURL))
        }
        let task = urlSession.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(Cart.self, from: data)
                completion(.success(results))
                
            } catch {
                completion(.failure(ErrorTypes.invalidMainData))
            }
        }
        task.resume()
    }
}

enum ErrorTypes: Error {
    case invalidURL
    case invalidMainData
    case invalidDetailsData
    case invalidCartData
    case networkError
    
    var identifier: String {
        let error: String
        switch self {
        case .invalidURL:
            error = "invalidURL"
        case .invalidMainData:
            error = "invalidMainData"
        case .invalidDetailsData:
            error = "invalidDetailsData"
        case .invalidCartData:
            error = "invalidMyCartData"
        case .networkError:
            error = "networkError"
        }
        return error
    }
}

