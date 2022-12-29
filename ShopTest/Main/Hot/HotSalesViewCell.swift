//
//  HotSalesViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 23.08.2022.
//

import UIKit

class HotSalesViewCell: UICollectionViewCell {
    
    public static let identifier = "HotSalesViewCell"
    
    var viewModel: HotSalesCollectionCellViewModelProtocol! {
        didSet {
            let urlString = URL(string: viewModel.image)
            imageView.kf.setImage(with: urlString)
            newButton.isHidden = !viewModel.isNew
            buyButton.isHidden = !viewModel.isBuy
            titleLabel.text = viewModel.brand
            subtitleLabel.text = viewModel.desctiption
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "review"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "review"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newButton: UIButton = {
        let button = UIButton()
        button.setTitle("New", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 1, green: 0.5189241767, blue: 0.3763272166, alpha: 1)
        button.layer.cornerRadius = 13
        button.isEnabled = false
        return button
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy now!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        setup()
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
        imageView.addSubview(newButton)
        imageView.addSubview(titleLabel)
        imageView.addSubview(subtitleLabel)
        imageView.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            newButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            newButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            newButton.heightAnchor.constraint(equalToConstant: 26),
            newButton.widthAnchor.constraint(equalToConstant: 26),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 13),
            
            buyButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 25),
            buyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            buyButton.heightAnchor.constraint(equalToConstant: 23),
            buyButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configure(_ hot: HomeStore) {
        titleLabel.text = hot.title
        subtitleLabel.text = hot.subtitle
        if hot.isNew == true {
        newButton.isHidden = false
        } else {
            newButton.isHidden = true
        }
        let urlString = URL(string: hot.picture)
        imageView.kf.setImage(with: urlString)
    }
}
