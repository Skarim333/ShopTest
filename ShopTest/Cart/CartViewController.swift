//
//  MyCartViewController.swift
//  ShopTest
//
//  Created by Карим Садыков on 27.08.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    var viewModel: CartViewModelProtocol! {
        didSet {
            viewModel.didLoadDataForCart = { [weak self] result in
                DispatchQueue.main.async {
                    if result {
                        self?.totalView.totalLabel.text = self?.viewModel.total
                        self?.totalView.deliveryLabel.text = self?.viewModel.delivery
                        self?.navigationController?.tabBarItem.badgeValue = String((self?.viewModel.basketCount)!)
                        self?.tableView.reloadData()
                    }
                }
            }
            
            viewModel.updateViews = { [weak self] viewModel in
                DispatchQueue.main.async {
                    self?.totalView.totalLabel.text = viewModel.total
                    self?.navigationController?.tabBarItem.badgeValue = self?.viewModel.basketCount == 0 ? nil : String((self?.viewModel.basketCount)!)
                }
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My cart"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.004242728464, green: 0.0249658227, blue: 0.2701849341, alpha: 1)
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Add address"
        label.tintColor = .mainBlue()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartViewCell.self, forCellReuseIdentifier: CartViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let totalView = TotalView()
    
    private let counterView: CounterView = {
        let view = CounterView(1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .mainOrange()
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupButton()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    func setup() {
        view.backgroundColor = .secondarySystemBackground
        totalView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(backView)
        backView.addSubview(tableView)
        backView.addSubview(totalView)
        backView.addSubview(checkoutButton)
        tableView.delegate = self
        tableView.dataSource  = self
    }
    
    func setupButton() {
        let leftButton = UIButton(type: .system)
        let leftImage = #imageLiteral(resourceName: "bigArrow").withRenderingMode(.alwaysOriginal)
        let rotatedLeftImage = leftImage.rotate(radians: .pi/2)?.withRenderingMode(.alwaysOriginal)
        leftButton.setImage(rotatedLeftImage, for: .normal)
        leftButton.tintColor = .white
        leftButton.backgroundColor = .mainBlue()
        leftButton.layer.cornerRadius = 10
        leftButton.addTarget(self, action: #selector(handleLeftBarButtonTap), for: .touchUpInside)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 44))
        leftView.addSubview(leftButton)
        
        NSLayoutConstraint.activate([
        
            leftView.widthAnchor.constraint(equalToConstant: 180),
            leftView.heightAnchor.constraint(equalToConstant: 44),
            
            leftButton.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 20),
            leftButton.widthAnchor.constraint(equalToConstant: 37),
            leftButton.heightAnchor.constraint(equalToConstant: 37)
            ])
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightButton = UIButton(type: .system)
        let rightImage = #imageLiteral(resourceName: "locationBig").withRenderingMode(.alwaysOriginal)
        rightButton.setImage(rightImage, for: .normal)
        rightButton.backgroundColor = .mainOrange()
        rightButton.layer.cornerRadius = 10
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.addTarget(self, action: #selector(handleRightBarButtonTap), for: .touchUpInside)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 44))
        
        locationLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 19)
        
        rightView.addSubview(locationLabel)
        rightView.addSubview(rightButton)

        NSLayoutConstraint.activate([
        
            rightView.widthAnchor.constraint(equalToConstant: 180),
            rightView.heightAnchor.constraint(equalToConstant: 44),
            
            rightButton.centerYAnchor.constraint(equalTo: rightView.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -20),
            rightButton.widthAnchor.constraint(equalToConstant: 37),
            rightButton.heightAnchor.constraint(equalToConstant: 37),
            
            locationLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -9),
            ])
        
        let rightBarButtonItem = UIBarButtonItem(customView: rightView)
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func handleLeftBarButtonTap() {
        print(#function)
        tabBarController?.selectedIndex = 0
    }
    
    @objc private func handleRightBarButtonTap() {
        print(#function)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            backView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: totalView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            totalView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -25),
            totalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalView.heightAnchor.constraint(equalToConstant: 90),
            
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basketCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartViewCell.identifier, for: indexPath) as? CartViewCell else { fatalError() }
        cell.viewModel = viewModel.getCartViewModel(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
