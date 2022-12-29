//
//  MainControllerB.swift
//  ShopTest
//
//  Created by Карим Садыков on 23.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    
    private lazy var alert = MyAlert()
    
    private let headerView = MainHeaderView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.register(CategoryTableViewCell.self,
                           forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.register(HotSalesTableViewCell.self,
                           forCellReuseIdentifier: HotSalesTableViewCell.identifier)
        tableView.register(BestSellerTableViewCell.self,
                           forCellReuseIdentifier: BestSellerTableViewCell.identifier)
        tableView.register(MainCellHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: MainCellHeaderView.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationItem()
        view.addSubview(headerView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        HotSalesTableViewCell.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(tapButton))
        navigationItem.rightBarButtonItem?.tintColor = .black
        guard let frame = navigationController?.navigationBar.frame else { return }
        headerView.frame = CGRect(x: frame.width * (1/4),
                                 y: 0,
                                  width: frame.width * 0.4,
                                 height: frame.height)
        navigationItem.titleView = headerView
    }

    @objc func tapButton() {
        alert.showAlert(viewController: self)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel as? CategoryTableCellViewModelProtocol
            cell.backgroundColor = .clear
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HotSalesTableViewCell.identifier, for: indexPath) as? HotSalesTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel as? HotSalesTableCellViewModelProtocol
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BestSellerTableViewCell.identifier, for: indexPath) as? BestSellerTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel as? BestSellerTableCellViewModelProtorol
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return tableView.frame.height / 5
        case 1: return tableView.frame.height / 4
        case 2: return BestSellerTableViewCell.SizesCell.calculateHeightTableCell(countItem: 4, widthTable: tableView.frame.width)
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainCellHeaderView.identifier) as! MainCellHeaderView
        let enumHeader = Headers(section: section)
        header.set(title: enumHeader.title, textButton: enumHeader.textButton)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}

extension MainViewController: PushDetailViewController {
    func pushDetailViewController() {
        viewModel.pushDetailView()
    }
}

extension MainViewController {
    fileprivate enum Headers: Int {
        case category
        case hotSales
        case bestSeller
        case none
        
        var title: String {
            switch self {
            case .category:
                return "Select Category"
            case .hotSales:
                return "Hot sales"
            case .bestSeller:
                return "Best seller"
            case .none:
                return ""
            }
        }
        
        var textButton: String {
            switch self {
            case .category:
                return "view all"
            case .hotSales:
                return "see more"
            case .bestSeller:
                return "see more"
            case .none:
                return ""
            }
        }
        
        init(section: Int) {
            switch section {
            case 0: self = .category
            case 1: self = .hotSales
            case 2: self = .bestSeller
            default: self = .none
            }
        }
    }
}

