//
//  CollectionDataSource.swift
//  MVVMCollection
//
//  Created by Alex on 08.08.22.
//

import UIKit

final class CollectionDataSource: NSObject {
    fileprivate var cellByNibPool: [AnyTableViewCell.Type] = []
    fileprivate var cellManualPool: [AnyTableViewCell.Type] = []
    
    private var viewModel: CollectionViewModel
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
    }
}

extension CollectionDataSource {
    func register(cellsByNib: [AnyTableViewCell.Type]) {
        cellByNibPool.append(contentsOf: cellsByNib)
    }
    
    func register(manualLayoutCells: [AnyTableViewCell.Type]) {
        cellManualPool.append(contentsOf: manualLayoutCells)
    }
}

// MARK: Main UITableViewDataSource
extension CollectionDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.itemSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemSections[safe: section]?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemDataSource = viewModel.getItemDataSource(for: indexPath) else {
            assertionFailure("Wrong indexPath")
            return UITableViewCell()
        }
        
        let dsType = type(of: itemDataSource)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dsType.id, for: indexPath) as? AnyTableViewCell else {
            assertionFailure("Wrong CellType")
            return UITableViewCell()
        }
        cell.setupAny(with: itemDataSource)
        
        return cell
    }
}

// MARK: Header/Footer UITableViewDataSource
extension CollectionDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        (viewModel.itemSections[safe: section] as? HeadedItemGroupViewModel)?.header
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        (viewModel.itemSections[safe: section] as? HeadedItemGroupViewModel)?.footer
    }
}



// MARK: - Helpers

extension CollectionViewModel {
    func getItemDataSource(for indexPath: IndexPath) -> ItemDataSource? {
        itemSections[safe: indexPath.section]?.items[safe: indexPath.row]?.makeDataSource()
    }
}

// MARK: UITableView + Helper

extension UITableView {
    func setup(collectionDataSource: CollectionDataSource) {
        
        for cellType in collectionDataSource.cellByNibPool {
            let bundle = Bundle(for: cellType)
            let nib = UINib(nibName: String(describing: self), bundle: bundle)
            self.register(nib, forCellReuseIdentifier: cellType.identifire)
        }
        
        for cellType in collectionDataSource.cellManualPool {
            self.register(cellType, forCellReuseIdentifier: cellType.identifire)
        }
        
        self.dataSource = collectionDataSource
    }
}
