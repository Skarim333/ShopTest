//
//  CategoryTableViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 23.11.2022.
//

import UIKit

protocol CategoryTableCellViewModelProtocol: MainViewModelProtocol {
    var indexSelectedItem: Int { get }
    var numberCategories: Int { get }
    func didSelectedItem(at index: Int)
    func getViewModel(at index: Int) -> CategoryCollectionCellViewModelProtocol
}

class CategoryTableViewCell: UITableViewCell {
    
    static let identifier = "CategoryTableViewCell"
    
    var viewModel: CategoryTableCellViewModelProtocol!
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainOrange()
        button.tintColor = .white
        let imageButton = #imageLiteral(resourceName: "qrcode").withRenderingMode(.alwaysOriginal)
        button.setImage(imageButton, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(searchTextField)
        contentView.addSubview(searchButton)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        let height = 20
        let view = UIView(frame: CGRect(x: 0, y: 0, width: height * 2, height: height))
        let image = UIImage(systemName: "magnifyingglass")
        let imageview = UIImageView(image: image)
        view.addSubview(imageview)
        imageview.center = view.center
        imageview.contentMode = .scaleAspectFit
        imageview.tintColor = .mainOrange()
        searchTextField.leftView = view
        searchTextField.leftViewMode = .always
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryCollectionView.frame = CGRect(x: 0, y: 0, width: width, height: height*7/10)
        searchTextField.frame = CGRect(x: 32, y: categoryCollectionView.bottom + 5, width: width*7/10, height: height*2/10)
        searchButton.frame = CGRect(x: searchTextField.right + 8, y: categoryCollectionView.bottom + 5, width: searchTextField.height, height: searchTextField.height)
        searchTextField.layer.cornerRadius = searchTextField.frame.height / 2
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        searchButton.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { fatalError() }
        cell.viewModel = viewModel.getViewModel(at: indexPath.row)
        return cell
    }  
}

// MARK: - UICollectionViewDelegate
extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: IndexPath(row: viewModel.indexSelectedItem, section: 0)) as! MainCollectionViewCell
        selectedCell.viewModel.didSelectedCell()

        viewModel.didSelectedItem(at: indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
        cell.viewModel.didSelectedCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
