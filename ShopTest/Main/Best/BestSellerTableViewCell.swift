//
//  BestSellerTableViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 26.11.2022.
//

import UIKit

protocol BestSellerTableCellViewModelProtorol: MainViewModelProtocol {
    var numberOfRowsBestSeller: Int { get }
    
    func getBestSellerViewModel(at index: Int) -> BestSellerCollectionCellViewModelProtocol
    
    var didLoadDataForBestSeller: ((Bool) -> Void)? { get set }
}

class BestSellerTableViewCell: UITableViewCell {
    
    static let identifier = "BestSellerTableViewCell"
    
    var viewModel: BestSellerTableCellViewModelProtorol! {
        didSet {
            viewModel.didLoadDataForBestSeller = { [weak self] result in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    if result {
                        strongSelf.bestSellerTableViewCell.isHidden = false
                        strongSelf.bestSellerTableViewCell.reloadData()
                    } else {
                        strongSelf.bestSellerTableViewCell.isHidden = true
                    }
                }
            }
        }
    }
    
    var bestSallers = [BestSeller]()
    var selectIndex = [-1]
 
    private let bestSellerTableViewCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BestSellerViewCell.self, forCellWithReuseIdentifier: BestSellerViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
//        getData()
        contentView.addSubview(bestSellerTableViewCell)
        bestSellerTableViewCell.dataSource = self
        bestSellerTableViewCell.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bestSellerTableViewCell.frame = CGRect(x: 0, y: 8, width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BestSellerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsBestSeller
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerViewCell.identifier, for: indexPath) as? BestSellerViewCell else { fatalError() }
        cell.viewModel = viewModel.getBestSellerViewModel(at: indexPath.row)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BestSellerTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? BestSellerViewCell
        if selectIndex.contains(indexPath.item) {
            if let index = selectIndex.firstIndex(of: indexPath.item) {
                cell?.selectImage.image = UIImage(systemName: "heart")
                selectIndex.remove(at: index)
            }
        } else {
            selectIndex.append(indexPath.item)
            cell?.selectImage.image = UIImage(systemName: "heart.fill")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BestSellerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        SizesCell.calculateSizeCollectionCell(width: collectionView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return SizesCell.minimumInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SizesCell.minimumLineSpacing
    }
}

extension BestSellerTableViewCell {
    struct SizesCell {
        static fileprivate let countCellInLine: Int = 2
        static fileprivate let minimumInteritemSpacing: CGFloat = 16
        static fileprivate let minimumLineSpacing: CGFloat = 16
        static fileprivate let paddingCollectionView = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)

        static fileprivate func calculateSizeCollectionCell(width: CGFloat) -> CGSize {
            let widthCell = width / CGFloat(countCellInLine) - 8
            return CGSize(width: widthCell,
                          height: widthCell * 1.2)
        }

        static internal func calculateHeightTableCell(countItem: Int, widthTable: CGFloat) -> CGFloat{
            let countLine = countItem / countCellInLine
            var height = paddingCollectionView.top +
                         paddingCollectionView.bottom
            let widthCollectionView = widthTable -
                                      paddingCollectionView.left -
                                      paddingCollectionView.right
            
            let sizeCell = calculateSizeCollectionCell(width: widthCollectionView)
            
            height = height + CGFloat(countLine) * (sizeCell.height + minimumLineSpacing)
            return height
        }
    }
}
