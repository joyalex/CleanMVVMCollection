//
//  RedBlueViewController.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

import UIKit

class RedBlueViewController: UITableViewController {
    private var viewModel: RedBlueViewModel
    private let tableDataSource: LateBindingDataSource
    private let tableDelegate: LateBindingDelegate
    
    init(viewModel: RedBlueViewModel) {
        self.viewModel = viewModel
        self.tableDataSource = LateBindingDataSource(viewModel: viewModel)
        self.tableDelegate = LateBindingDelegate(viewModel: viewModel)
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: Setup
extension RedBlueViewController {
    func setupDataSource() {
        tableDataSource.register(manualLayoutCells: [BadCell.self,
                                                     RedCell.self,
                                                     BlueCell.self])
        
        tableView.setup(tableDataSource: tableDataSource)
        tableView.delegate = tableDelegate
    }
    
    func setupTabPresentation() {
        tabBarItem = UITabBarItem(
            title: "Table",
            image: UIImage(systemName: "point.3.connected.trianglepath.dotted"),
            selectedImage: UIImage(systemName: "point.3.filled.connected.trianglepath.dotted")
        )
    }
}
