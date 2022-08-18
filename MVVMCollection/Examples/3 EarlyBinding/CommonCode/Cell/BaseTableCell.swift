//
//  BaseTableCell.swift
//  MVVMCollection
//
//  Created by Alex on 18.08.22.
//

import UIKit

// MARK:  View Layer
open class BaseTableCell<VM>: UITableViewCell, TableViewCell {

    var viewModel: VM!
    
    public func setup(dataSource: GeneralItemSource<VM>) {
        viewModel = dataSource.viewModel
        setup(by: viewModel)
    }
    
    open func setup(by viewModel: VM) {
        accessoryType = (self as? ItemViewModelWithAction)?.hasTapAction == true ? .disclosureIndicator : .none
    }
}


// MARK: Helper
extension ItemViewModelWithAction {
    var hasTapAction: Bool {
        actions.contains { $0 is ItemTapAction } == true
    }
}
