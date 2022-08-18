//
//  EarlyBindingViewController.swift
//  MVVMCollection
//
//  Created by Alex on 13.08.22.
//

import UIKit

class BlackWhiteViewController: UITableViewController {
    private var viewModel: BlackWhiteViewModel
    private let dataSource: CollectionDataSource
    private let delegate: CollectionDelegate
    
    init(viewModel: BlackWhiteViewModel) {
        self.viewModel = viewModel
        self.dataSource = CollectionDataSource(viewModel: viewModel)
        self.delegate = CollectionDelegate(viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
        setupTabPresentation()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        tableView.delegate = delegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: Setup
extension BlackWhiteViewController {
    func setupDataSource() {
        dataSource.register(manualLayoutCells: [TemperatureCell.self,
                                                DistanceCell.self])
        tableView.setup(collectionDataSource: dataSource)
    }
    
    func setupTabPresentation() {
        tabBarItem = UITabBarItem(
            title: "Table",
            image: UIImage(systemName: "aspectratio"),
            selectedImage: UIImage(systemName: "aspectratio.fill")
        )
    }
}

// MARK: UITableViewDelegate
extension BlackWhiteViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
