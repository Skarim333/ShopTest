//
//  CounterView.swift
//  ShopTest
//
//  Created by Карим Садыков on 27.11.2022.
//

import UIKit

class CounterView: UIView {
    
    var counter: Int {
        didSet {
            countLabel.text = String(counter)
        }
    }
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return button
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("−", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    init(_ startCount: Int) {
        counter = startCount
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        counter = 1
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        plusButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*1/3)
        countLabel.frame = CGRect(x: 0, y: plusButton.bottom, width: self.frame.width, height: self.frame.height*1/3)
        minusButton.frame = CGRect(x: 0, y: countLabel.bottom, width: self.frame.width, height: self.frame.height*1/3)
        
    }
    private func setup() {
        backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 67/255, alpha: 1)
        addSubview(minusButton)
        addSubview(countLabel)
        addSubview(plusButton)
        
    }

    func addTargerButton(target: Any?, plusSelector: Selector, minusSelector: Selector) {
        
        plusButton.addTarget(target, action: plusSelector, for: .touchUpInside)
        minusButton.addTarget(target, action: minusSelector, for: .touchUpInside)
    }
}
