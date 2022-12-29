//
//  MainHeaderView.swift
//  ShopTest
//
//  Created by Карим Садыков on 23.11.2022.
//

import UIKit

class MainCellHeaderView: UITableViewHeaderFooterView {

    static let identifier = "MainHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.mainOrange(), for: .normal)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let horStack = [titleLabel,
                        seeMoreButton]
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addSubviewsToStack(horStack)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        horizontalStackView.frame = CGRect(x: 15,
                                           y: 0,
                                           width: self.frame.width - 30,
                                           height: height)
    }
    
    func set(title: String, textButton: String) {
        titleLabel.text = title
        seeMoreButton.setTitle(textButton, for: .normal)
    }
}
