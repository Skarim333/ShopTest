//
//  CartViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 28.08.2022.
//

import Foundation
import UIKit


class CartViewCell: UITableViewCell {
    
    public static let identifier = "cell"
    var viewModel: CartViewCellViewModelProtocol! {
        didSet {
            let urlString = URL(string: viewModel.images)
            cartImageView.kf.setImage(with: urlString)
            setSubviews()
        }
    }
    
    private let counterView: CounterView = {
        let view = CounterView(1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "heart")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titlereview"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "pricereview"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        return button
    }()
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        selectionStyle = .none
        self.backgroundColor = #colorLiteral(red: 0.004242728464, green: 0.0249658227, blue: 0.2701849341, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        counterView.layer.cornerRadius = 15
        counterView.clipsToBounds = true
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    func setup() {
        contentView.addSubview(cartImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(deleteButton)
        contentView.addSubview(counterView)
        counterView.addTargerButton(target: self,
                                    plusSelector:#selector(didTouchPlusButtonCounterView),
                                    minusSelector: #selector(didTouchMinusButtonCounterView))
        NSLayoutConstraint.activate([
            cartImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cartImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cartImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cartImageView.widthAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: cartImageView.trailingAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: cartImageView.trailingAnchor, constant: 5),
            priceLabel.heightAnchor.constraint(equalToConstant: 22),
            
            counterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            counterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            counterView.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10),
            counterView.widthAnchor.constraint(equalToConstant: 30),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    @objc private func didTouchPlusButtonCounterView() {
        counterView.counter += 1
        viewModel.changePrice(counterView.counter)
        priceLabel.text = String("$" + "\(Double(viewModel.price))")
    }
    
    @objc private func didTouchMinusButtonCounterView() {
        counterView.counter -= counterView.counter > 0 ? 1 : 0
        viewModel.changePrice(counterView.counter)
        priceLabel.text = String("$" + "\(Double(viewModel.price))")
    }
    
    private func setSubviews() {
        titleLabel.text = viewModel.title
        priceLabel.text = String("$" + "\(Double(viewModel.price))")
    }
    
    func configure(_ best: Basket) {
        titleLabel.text = best.title
        priceLabel.text = String("$" + "\(Double(best.price))")
        let urlString = URL(string: best.images)
        cartImageView.kf.setImage(with: urlString)
    }
}
