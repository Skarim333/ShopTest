//
//  DetailViewModel.swift
//  ShopTest
//
//  Created by Карим Садыков on 20.12.2022.
//

import Foundation

protocol DetailsViewModelProtocol {
    var nameDevice: String { get }
    var isFavorites: Bool { get }
    var CPU: String { get }
    var camera: String { get }
    var sd: String { get }
    var ssd: String { get }
    var capacity: [String] { get }
    var color: [String] { get }
    var price: String { get }
    var rating: Int { get }
    var images: [String] { get }
    var numberOfPhotos: Int { get }
    var sectionsOfInfo: [String] { get }
    var didLoadDataForDetail: ((Bool) -> Void)? { get set }
    
    var didLoadDataForView: ((DetailsViewModelProtocol) -> Void)? { get set }
    var changedFavorites: (() -> Void)? { get set }
    var didLoadImage: (() -> Void)? { get set }
    func didTouchFavorites()
    func didTouchAddCart()
    func getImageData(at index: Int) -> Data?
    func backButtonTapped()
    func viewDidDisappear()
    
    var numberOfItemsInSection: Int { get }
    func getDetailViewModel(at index: Int) -> ImageViewCellViewModelProtocol
    
    func addProduct(_ count: Int)
}

class DetailsViewModel: DetailsViewModelProtocol {
  
    weak var delegate: CartTableCellViewModelDelegate?
    //MARK: private property
    private var detailsData: Details?
    private var isFavorite: Bool = false
    private var imagesData: [Data] = []
    private var didLoadDetailData: ((Bool) -> Void)?
    var coordinator: DetailCoordinator?
    
    //MARK: protocol property
    var nameDevice: String {
        detailsData?.title ?? ""
    }
    
    var isFavorites: Bool {
        isFavorite
    }
    
    var CPU: String {
        detailsData?.CPU ?? ""
    }
    
    var camera: String {
        detailsData?.camera ?? ""
    }
    
    var sd: String {
        detailsData?.sd ?? ""
    }
    
    var ssd: String {
        detailsData?.ssd ?? ""
    }
    
    var capacity: [String] {
        detailsData?.capacity.map { $0 + " GB"} ?? []
    }
    
    var color: [String] {
        detailsData?.color ?? []
    }
    
    var rating: Int {
        Int(detailsData?.rating ?? 0)
    }
    
    var images: [String] {
        detailsData?.images ?? []
    }
    
    var numberOfPhotos: Int {
        imagesData.count
    }
    
    var price: String {
        let title = "Add to Cart"
        let tap = String(repeating: " ", count: 10)
        if let price = detailsData?.price {
            return title + tap + String.convertNumberInPrice(for: price as NSNumber, isOutDouble: true)
        } else {
            return title + tap
        }
    }
    
    
    
    var sectionsOfInfo: [String] {
        return ["Shop", "Details", "Features"]
    }
    
    //MARK: protocol callback
    var didLoadDataForView: ((DetailsViewModelProtocol) -> Void)?
    var didLoadDataForDetail: ((Bool) -> Void)? {
        get { didLoadDetailData }
        set { didLoadDetailData = newValue }
    }
    var changedFavorites: (() -> Void)?
    var didLoadImage: (() -> Void)?
    
    //MARK: init
    required init() {
        loadData()
    }
    
    //MARK: protocol methods
    
    func didTouchFavorites() {
        isFavorite.toggle()
        changedFavorites?()
    }
    
    func didTouchAddCart() {

    }
    
    func getImageData(at index: Int) -> Data? {
        guard index <= imagesData.count || !imagesData.isEmpty else { return nil }
        return imagesData[index]
    }
    
    //MARK: private methods
    private func loadData() {
        APICaller.shared.getDetails { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.detailsData = data
                    self?.isFavorite = data.isFavorites
                    self?.didLoadDetailData?(true)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfItemsInSection: Int {
        images.count
    }
    
    func getDetailViewModel(at index: Int) -> ImageViewCellViewModelProtocol {
       ImageViewCellViewModel(images[index])
    }
    
    func backButtonTapped() {
        coordinator?.didFinishDetailScene()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func addProduct(_ count: Int) {
        delegate?.didChangeCountProduct(1, newCount: count)
    }
}

