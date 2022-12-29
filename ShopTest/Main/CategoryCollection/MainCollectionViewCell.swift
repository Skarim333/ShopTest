//
//  MainCollectionViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 23.08.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    public static let identifier = "MainCollectionViewCell"
    var viewModel: CategoryCollectionCellViewModelProtocol! {
        didSet {
            viewModel.changedViewModel = { [weak self] viewModel in
                self?.select(isSelect: viewModel.isSelectCell)
            }
            titleLabel.text = viewModel.nameCategory
            if let icon = UIImage(systemName: viewModel.nameIconCategory) {
                imageView.image = icon.withRenderingMode(.alwaysTemplate)
            }

            select(isSelect: viewModel.isSelectCell)
        }
    }
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "review"
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        backView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        imageView.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        titleLabel.frame = CGRect(x: 0, y: backView.bottom+3, width: self.frame.width, height: 13)
        backView.layer.cornerRadius = 35
    }
    
    func setup() {
        contentView.addSubview(backView)
        backView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    func configure(_ image: String, _ name: String) {
        imageView.image = UIImage(systemName: image)
        titleLabel.text = name
    }
    
    private func select(isSelect: Bool) {
        if isSelect {
            backView.backgroundColor = .mainOrange()
            imageView.tintColor = .white
        } else {
            titleLabel.textColor = .black
            imageView.tintColor = .systemGray2
            backView.backgroundColor = .white
        }
    }
}
