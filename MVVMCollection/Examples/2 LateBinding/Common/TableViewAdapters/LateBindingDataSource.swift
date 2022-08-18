//
//  LateBindingDataSource.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

import UIKit

final class LateBindingDataSource: NSObject {
    
    fileprivate var cellByNibPool: [LBAnyTableViewCell.Type] = []
    fileprivate var cellManualPool: [LBAnyTableViewCell.Type] = []
    
    private var cachedBinding: [ObjectIdentifier: String] = [:]
    
    private var cellPool: [LBAnyTableViewCell.Type] {
        cellByNibPool + cellManualPool
    }
    
    private var viewModel: LBCollectionViewModel
    
    init(viewModel: LBCollectionViewModel) {
        self.viewModel = viewModel
    }
}

extension LateBindingDataSource {
    func register(cellsByNib: [LBAnyTableViewCell.Type]) {
        cellByNibPool.append(contentsOf: cellsByNib)
    }
    
    func register(manualLayoutCells: [LBAnyTableViewCell.Type]) {
        cellManualPool.append(contentsOf: manualLayoutCells)
    }
}

// MARK: Main UITableViewDataSource
extension LateBindingDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[safe: section]?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemViewModel = viewModel.getItem(for: indexPath) else {
            assertionFailure("Wrong indexPath")
            return UITableViewCell()
        }
        
        guard let cellIdentifire = makeLateBindingIfNeed(for: itemViewModel) else {
            assertionFailure("Unknown ViewModel")
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? LBAnyTableViewCell else {
            assertionFailure("Wrong CellType")
            return UITableViewCell()
        }
        cell.setupAny(with: itemViewModel)
        
        return cell
    }
    
    private func makeLateBindingIfNeed(for itemViewModel: LBItemViewModel) -> String? {
        let viewModelType = type(of: itemViewModel)
        let viewModelTypeId = ObjectIdentifier(viewModelType)
        
        if let identifire = cachedBinding[viewModelTypeId] {
            return identifire
        }
        
        guard let CellType = cellPool.first(where: { $0.canSetup(by: itemViewModel) } ) else {
            assertionFailure("Unknown ViewModel")
            return nil
        }
        
        cachedBinding[viewModelTypeId] = CellType.identifire
        
        return CellType.identifire
    }
}

// MARK: Header/Footer UITableViewDataSource
extension LateBindingDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        (viewModel.sections[safe: section] as? LBHeadedFooterSectionViewModel)?.header
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        (viewModel.sections[safe: section] as? LBHeadedFooterSectionViewModel)?.footer
    }
}



// MARK: - Helpers

extension LBCollectionViewModel {
    func getItem(for indexPath: IndexPath) -> LBItemViewModel? {
        sections[safe: indexPath.section]?.items[safe: indexPath.row]
    }
}

// MARK: UITableView + Helper

extension UITableView {
    func setup(tableDataSource: LateBindingDataSource) {
        
        for cellType in tableDataSource.cellByNibPool {
            let bundle = Bundle(for: cellType)
            let nib = UINib(nibName: String(describing: self), bundle: bundle)
            self.register(nib, forCellReuseIdentifier: cellType.identifire)
        }
        
        for cellType in tableDataSource.cellManualPool {
            self.register(cellType, forCellReuseIdentifier: cellType.identifire)
        }
        
        self.dataSource = tableDataSource
    }
}
