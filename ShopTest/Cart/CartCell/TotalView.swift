//
//  CartVeiw.swift
//  ShopTest
//
//  Created by Карим Садыков on 28.08.2022.
//

import Foundation
import UIKit

class TotalView: UIView {
    
    private let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        view.layer.opacity = 0.25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleTotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total"
        label.textColor = .white
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textColor = .white
        return label
    }()
    
    private let titleDeliveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delivery"
        label.textColor = .white
        return label
    }()
    
    let deliveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textColor = .white
        return label
    }()
    
    private let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        view.layer.opacity = 0.25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
       setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup () {
        addSubview(topBorder)
        addSubview(titleTotalLabel)
        addSubview(totalLabel)
        addSubview(titleDeliveryLabel)
        addSubview(deliveryLabel)
        addSubview(bottomBorder)
        
        NSLayoutConstraint.activate([
            
            topBorder.topAnchor.constraint(equalTo: topAnchor),
            topBorder.heightAnchor.constraint(equalToConstant: 2),
            topBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleTotalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleTotalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            titleTotalLabel.heightAnchor.constraint(equalToConstant: 17),
            
            totalLabel.centerYAnchor.constraint(equalTo: titleTotalLabel.centerYAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            totalLabel.heightAnchor.constraint(equalToConstant: 17),
            
            titleDeliveryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 45),
            titleDeliveryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            titleDeliveryLabel.heightAnchor.constraint(equalToConstant: 17),
            
            deliveryLabel.centerYAnchor.constraint(equalTo: titleDeliveryLabel.centerYAnchor),
            deliveryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            deliveryLabel.heightAnchor.constraint(equalToConstant: 17),
            
            bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 2),
            bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
}
