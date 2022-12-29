//
//  MainViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 18.12.2022.
//

import UIKit

protocol MainViewModelProtocol: AnyObject {
    var title: String { get }
    func pushDetailView()
}

class MainViewModel: MainViewModelProtocol {
    
    private let categories: [CategoryProduct]
    private var selectedCategory: CategoryProduct
    private var hotSalesModels: [HomeStore] = []
    private var bestSellesModels: [BestSeller] = []
    var coordinator: MainCoordinator?
    
    private var didLoadBestSellerData: ((Bool) -> Void)?
    private var didLoadHotSalesData: ((Bool) -> Void)?
    
    init() {
        categories = CategoryProduct.allCases
        selectedCategory = .Phones
        getData()
    }
    
    var title: String {
        return "Zihuatanejo, Gro"
    }
    
    func getData() {
        APICaller.shared.getMain { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.hotSalesModels = data.homeStore
                    self?.bestSellesModels = data.bestSeller
                    self?.didLoadBestSellerData?(true)
                    self?.didLoadHotSalesData?(true)
                }
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
    }
    
    func pushDetailView() {
        self.coordinator?.startDetailScene()
    }
    
    
    
}

extension MainViewModel: CategoryTableCellViewModelProtocol {
    var numberCategories: Int {
        categories.count
    }
    
    func getViewModel(at index: Int) -> CategoryCollectionCellViewModelProtocol {
        let product = categories[index]
        let isSelect = product == selectedCategory
        return CategoryCollectionCellViewModel(product, isSelect: isSelect)
    }
    
    var indexSelectedItem: Int {
        return categories.firstIndex(of: selectedCategory) ?? 0
    }
    
    func didSelectedItem(at index: Int) {
        let product = categories[index]
        selectedCategory = product
    }
}

extension MainViewModel: HotSalesTableCellViewModelProtocol {
    var numberOfRowsHotSales: Int {
        hotSalesModels.count
    }
    
    func getHotSalesViewModel(at index: Int) -> HotSalesCollectionCellViewModelProtocol {
        HotSalesCollectionCellViewModel(model: hotSalesModels[index])
    }
    
    var didLoadDataForHotSales: ((Bool) -> Void)? {
        get { didLoadHotSalesData }
        set { didLoadHotSalesData = newValue }
    }
    
}

extension MainViewModel: BestSellerTableCellViewModelProtorol {
    var numberOfRowsBestSeller: Int {
        bestSellesModels.count
    }
    
    func getBestSellerViewModel(at index: Int) -> BestSellerCollectionCellViewModelProtocol {
        BestSellerCollectionCellViewModel(bestSellesModels[index])
    }
    
    var didLoadDataForBestSeller: ((Bool) -> Void)? {
        get { didLoadBestSellerData }
        set { didLoadBestSellerData = newValue }
    }
    
}
