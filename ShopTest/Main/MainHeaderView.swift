//
//  MainHeaderView.swift
//  ShopTest
//
//  Created by Карим Садыков on 29.12.2022.
//

import UIKit

class MainHeaderView: UIView {
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Zihuatanejo, Gro"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.tintColor = .mainBlue()
        return label
    }()
    private let locationImage = UIImageView(image: #imageLiteral(resourceName: "location"))
    private let arrowImage = UIImageView(image: #imageLiteral(resourceName: "bigArrow"))
    private var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        let stack = [locationImage,
                     locationLabel,
                     arrowImage]
        addSubview(headerStackView)
        headerStackView.addSubviewsToStack(stack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerStackView.frame = self.bounds
    }
}
