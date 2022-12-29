//
//  DetailViewController.swift
//  ShopTest
//
//  Created by Карим Садыков on 24.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModelProtocol! {
        didSet {
            viewModel.didLoadDataForDetail = { [weak self] result in
                DispatchQueue.main.async {
                    if result {
                        self?.detailCollectionView.reloadData()
                        self?.ratingCollectionView.reloadData()
                        self?.cpuLabel.text = self?.viewModel.CPU
                        self?.camLabel.text = self?.viewModel.camera
                        self?.sdLabel.text = self?.viewModel.sd
                        self?.ssdLabel.text = self?.viewModel.ssd
                    }
                }
            }
        }
    }
    
    var image = [String]()
    var capacity = [String]()
    var color = [String]()
    var ratings = 0
    var countProduct = 0
    
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Galaxy Note 20 Ultra"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let customSegmentedConrol: CustomSegmentedControl = {
        let view = CustomSegmentedControl()
        view.setButtonTitles(buttonTitles: ["Shop", "Details", "Features"])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let cpuImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        image.image = UIImage(systemName: "cpu")
        return image
    }()
    
    private let cpuLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    private let camImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        image.image = UIImage(systemName: "camera")
        return image
    }()
    
    private let camLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        return label
    }()
    
    private let ssdImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        image.image = UIImage(systemName: "ticket")
        return image
    }()
    
    private let ssdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        return label
    }()
    
    private let sdImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        image.image = UIImage(systemName: "sdcard")
        return image
    }()
    
    private let sdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        return label
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select color and capacity"
        return label
    }()
    
    private let colorSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["", ""])
        control.selectedSegmentTintColor = .systemRed
        control.backgroundColor = .white
        control.selectedSegmentIndex = 0
        control.layer.borderWidth = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return button
    }()
    
    private let detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let ratingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RatingViewCell.self, forCellWithReuseIdentifier: RatingViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
 
    private lazy var selectGB128: UIButton = {
        let button = UIButton()
        button.setTitle("128 GB", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Mark Pro Bold", size: 13)
        button.addTarget(self, action: #selector(selectGB), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var selectGB256: UIButton = {
        let button = UIButton()
        button.setTitle("256 GB", for: .normal)
        button.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Mark Pro", size: 13)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(selectGB), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var brownButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBrown()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 40 / 2
        button.addTarget(self, action: #selector(colorTappet), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var darkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainBlue()
        button.tintColor = .white
        button.layer.cornerRadius = 40 / 2
        button.addTarget(self, action: #selector(colorTappet), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func selectGB(btn: UIButton){
        if btn == selectGB256{
            selectGB256.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1)
            selectGB256.setTitleColor(.white, for: .normal)
            selectGB128.backgroundColor = .clear
            selectGB128.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1), for: .normal)
        }else{
            selectGB128.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1)
            selectGB128.setTitleColor(.white, for: .normal)
            selectGB256.backgroundColor = .clear
            selectGB256.setTitleColor(UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1), for: .normal)
        }
    }
    
    @objc func colorTappet(btn: UIButton){
        if btn == brownButton{
            brownButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            darkButton.setImage(UIImage(), for: .normal)
        }else{
            darkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            brownButton.setImage(UIImage(), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product Details"
        setup()
        setupLeftBackButton()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    func setupLeftBackButton() {
        let leftButton = UIButton(type: .system)
        let leftImage = #imageLiteral(resourceName: "bigArrow").withRenderingMode(.alwaysOriginal)
        let rotatedLeftImage = leftImage.rotate(radians: .pi/2)?.withRenderingMode(.alwaysOriginal)
        leftButton.setImage(rotatedLeftImage, for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        leftButton.backgroundColor = .mainBlue()
        leftButton.layer.cornerRadius = 10
        leftButton.addTarget(self, action: #selector(handleLeftBarButtonTap), for: .touchUpInside)

        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightButton = UIButton(type: .system)
        let rightImage = #imageLiteral(resourceName: "cartTab").withRenderingMode(.alwaysOriginal)
        rightButton.setImage(rightImage, for: .normal)
        rightButton.backgroundColor = .mainOrange()
        rightButton.layer.cornerRadius = 10
        rightButton.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        rightButton.addTarget(self, action: #selector(handleRightBarButtonTap), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc private func handleLeftBarButtonTap() {
        print(#function)
        viewModel.backButtonTapped()
    }
    
    @objc private func handleRightBarButtonTap() {
        print(#function)
    }
    func setup () {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(customSegmentedConrol)
        backView.addSubview(colorLabel)
        backView.addSubview(addButton)
        backView.addSubview(ratingCollectionView)
        backView.addSubview(selectGB128)
        backView.addSubview(selectGB256)
        backView.addSubview(brownButton)
        backView.addSubview(darkButton)
        view.addSubview(detailCollectionView)
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        ratingCollectionView.delegate = self
        ratingCollectionView.dataSource = self
        addButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func setupConstraints() {
        let cpuStack = UIStackView(arrangedSubviews: [cpuImage, cpuLabel])
        cpuStack.axis = .vertical
        cpuStack.spacing = 5
        let camStack = UIStackView(arrangedSubviews: [camImage, camLabel])
        camStack.axis = .vertical
        camStack.spacing = 5
        let ssdStack = UIStackView(arrangedSubviews: [ssdImage, ssdLabel])
        ssdStack.axis = .vertical
        ssdStack.spacing = 5
        let sdStack = UIStackView(arrangedSubviews: [sdImage, sdLabel])
        sdStack.axis = .vertical
        sdStack.spacing = 5
        let stack = UIStackView(arrangedSubviews: [cpuStack, camStack, ssdStack, sdStack])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 40
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            detailCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            backView.topAnchor.constraint(equalTo: detailCollectionView.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backView.heightAnchor.constraint(equalToConstant: 450),
            
            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 40),
            titleLabel.heightAnchor.constraint(equalToConstant: 26),
            
            ratingCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            ratingCollectionView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 40),
            ratingCollectionView.heightAnchor.constraint(equalToConstant: 20),
            ratingCollectionView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -200),
            
            customSegmentedConrol.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            customSegmentedConrol.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            customSegmentedConrol.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            customSegmentedConrol.heightAnchor.constraint(equalToConstant: 40),
            
            stack.topAnchor.constraint(equalTo: customSegmentedConrol.bottomAnchor, constant: 30),
            stack.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -40),
            stack.heightAnchor.constraint(equalToConstant: 50),
            
            colorLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            colorLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 30),
            colorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            selectGB128.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
            selectGB128.trailingAnchor.constraint(equalTo: selectGB256.leadingAnchor, constant: -20),
            selectGB128.heightAnchor.constraint(equalToConstant: 30),
            selectGB128.widthAnchor.constraint(equalToConstant: 70),
            
            selectGB256.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
            selectGB256.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -60),
            selectGB256.heightAnchor.constraint(equalToConstant: 30),
            selectGB256.widthAnchor.constraint(equalToConstant: 70),
            
            brownButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
            brownButton.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 30),
            brownButton.heightAnchor.constraint(equalToConstant: 40),
            brownButton.widthAnchor.constraint(equalToConstant: 40),
            
            darkButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20),
            darkButton.leadingAnchor.constraint(equalTo: brownButton.trailingAnchor, constant: 20),
            darkButton.heightAnchor.constraint(equalToConstant: 40),
            darkButton.widthAnchor.constraint(equalToConstant: 40),
            
            addButton.bottomAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addButton.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 30),
            addButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -30),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func tapButton() {
        countProduct += 1
        viewModel.addProduct(countProduct)
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailCollectionView {
            return viewModel.numberOfItemsInSection
        }
        return viewModel.rating
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == detailCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell else { fatalError() }
            cell.viewModel = viewModel.getDetailViewModel(at: indexPath.row)
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RatingViewCell.identifier, for: indexPath) as? RatingViewCell else { fatalError() }
        return cell
        
    }
    
}



// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == detailCollectionView {
            return CGSize(width: detailCollectionView.frame.width - 130, height: detailCollectionView.frame.height - 40)
        }
        return CGSize(width: 18, height: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == ratingCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        }
        return UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
    }
}

