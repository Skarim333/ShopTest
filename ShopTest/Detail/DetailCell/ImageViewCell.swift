//
//  DetailsViewCell.swift
//  ShopTest
//
//  Created by Карим Садыков on 24.08.2022.
//

import UIKit
import Kingfisher

class ImageViewCell: UICollectionViewCell {
    public static let identifier = "cell"
    
    var viewModel: ImageViewCellViewModelProtocol! {
        didSet {
            let urlString = URL(string: viewModel.image)
            imageView.kf.setImage(with: urlString)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = nil
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

}
