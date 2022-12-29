//
//  MyAlert.swift
//  ShopTest
//
//  Created by Карим Садыков on 25.08.2022.
//

import Foundation
import UIKit

class MyAlert {
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let background: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "done")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .mainOrange()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let canselButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cross")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .mainBlue()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let labelButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filter options"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Brand"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Size"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let brandTextView: UITextField = {
        let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Samsung"
        textView.borderStyle = .bezel
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }()
    
    let priceTextView: UITextField = {
        let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "$300 - $500"
        textView.borderStyle = .bezel
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }()
    
    let sizeTextView: UITextField = {
        let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "4.5 to 5.5 inches"
        textView.borderStyle = .bezel
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }()

    func showAlert(viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        background.frame = targetView.bounds
        targetView.addSubview(background)
        targetView.addSubview(alertView)
        alertView.addSubview(canselButton)
        alertView.addSubview(doneButton)
        alertView.addSubview(labelButton)
        alertView.addSubview(brandLabel)
        alertView.addSubview(brandTextView)
        alertView.addSubview(priceLabel)
        alertView.addSubview(priceTextView)
        alertView.addSubview(sizeLabel)
        alertView.addSubview(sizeTextView)
        canselButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        NSLayoutConstraint.activate([
            alertView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor),
            alertView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
            alertView.heightAnchor.constraint(equalToConstant: 400),
            alertView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor),
            
            canselButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 24),
            canselButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 44),
            canselButton.widthAnchor.constraint(equalToConstant: 37),
            canselButton.heightAnchor.constraint(equalToConstant: 37),
            
            doneButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 24),
            doneButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            doneButton.widthAnchor.constraint(equalToConstant: 86),
            doneButton.heightAnchor.constraint(equalToConstant: 37),
            
            labelButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 30),
            labelButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            
            brandLabel.bottomAnchor.constraint(equalTo: brandTextView.topAnchor, constant: -10),
            brandLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 45),
            
            brandTextView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 110),
            brandTextView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 45),
            brandTextView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -30),
            brandTextView.heightAnchor.constraint(equalToConstant: 37),
            
            priceLabel.bottomAnchor.constraint(equalTo: priceTextView.topAnchor, constant: -10),
            priceLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 45),
            
            priceTextView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 190),
            priceTextView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 45),
            priceTextView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -30),
            priceTextView.heightAnchor.constraint(equalToConstant: 37),
            
            sizeLabel.bottomAnchor.constraint(equalTo: sizeTextView.topAnchor, constant: -10),
            sizeLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 45),
            
            sizeTextView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 270),
            sizeTextView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 45),
            sizeTextView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -30),
            sizeTextView.heightAnchor.constraint(equalToConstant: 37),
            
        ])
        
    }
    
        
    
    
    @objc func dismissAlert() {
        background.removeFromSuperview()
        alertView.removeFromSuperview()
    }
}
