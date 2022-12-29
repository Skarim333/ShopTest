//
//  BestSellerViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 23.08.2022.
//

import UIKit
import Kingfisher

class BestSellerViewCell: UICollectionViewCell {
    
    public static let identifier = "BestSellerViewCell"
    
    var viewModel: BestSellerCollectionCellViewModelProtocol! {
        didSet {
            let urlString = URL(string: viewModel.image)
            imageView.kf.setImage(with: urlString)
            subtitleLabel.text = viewModel.title
            print(viewModel.price)
            titleLabel.text = viewModel.price
            
            
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let backSelectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.5
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    let selectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        imageView.image = UIImage(systemName: "heart")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "review"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "review"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(backSelectView)
        backSelectView.addSubview(selectImage)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 170),
            
            backSelectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            backSelectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            backSelectView.heightAnchor.constraint(equalToConstant: 25),
            backSelectView.widthAnchor.constraint(equalToConstant: 25),
            
            selectImage.topAnchor.constraint(equalTo: backSelectView.topAnchor, constant: 5),
            selectImage.leadingAnchor.constraint(equalTo: backSelectView.leadingAnchor, constant: 5),
            selectImage.trailingAnchor.constraint(equalTo: backSelectView.trailingAnchor, constant: -5),
            selectImage.bottomAnchor.constraint(equalTo: backSelectView.bottomAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    func configure(_ best: BestSeller) {
        titleLabel.text = "$" + "\(best.priceWithoutDiscount)"
        subtitleLabel.text = best.title
        let urlString = URL(string: best.picture)
        imageView.kf.setImage(with: urlString)
    }
}

extension String {
    fileprivate func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
