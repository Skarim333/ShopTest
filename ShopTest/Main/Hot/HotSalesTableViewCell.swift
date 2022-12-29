//
//  HotSalesTableViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 26.11.2022.
//

import UIKit

protocol PushDetailViewController: AnyObject {
    func pushDetailViewController()
}

protocol HotSalesTableCellViewModelProtocol: MainViewModelProtocol {
    var numberOfRowsHotSales: Int { get }
    
    func getHotSalesViewModel(at index: Int) -> HotSalesCollectionCellViewModelProtocol
    
    var didLoadDataForHotSales: ((Bool) -> Void)? { get set }
    

}

class HotSalesTableViewCell: UITableViewCell {
    
    static let identifier = "HotSalesTableViewCell"
    
    var hotSales = [HomeStore]()
    static var delegate: PushDetailViewController?
    
    var viewModel: HotSalesTableCellViewModelProtocol! {
        didSet {
            viewModel.didLoadDataForHotSales = { [weak self] result in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    if result {
                        strongSelf.hotSalesCollectionView.reloadData()
                    } else {
                        strongSelf.hotSalesCollectionView.isHidden = true
                    }
                }
            }
        }
    }
    
    private let hotSalesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HotSalesViewCell.self, forCellWithReuseIdentifier: HotSalesViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(hotSalesCollectionView)
        hotSalesCollectionView.delegate = self
        hotSalesCollectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hotSalesCollectionView.frame = CGRect(x: 0, y: 8, width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HotSalesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsHotSales
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesViewCell.identifier, for: indexPath) as? HotSalesViewCell else { fatalError() }
        cell.viewModel = viewModel.getHotSalesViewModel(at: indexPath.row)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HotSalesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HotSalesTableViewCell.delegate?.pushDetailViewController()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HotSalesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 8,
                      height: collectionView.frame.height)
    }
}
