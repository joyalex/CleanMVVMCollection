//
//  UITableView+LateBinding.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

import UIKit

/// Пример с поздним связованием

// MARK: - Type Erasure
// MARK: Any
public protocol LBAnyTableViewCell: UITableViewCell {
    static func canSetup(by viewModelType: LBItemViewModel) -> Bool
    
    func setupAny(with viewModel: LBItemViewModel)
}

extension LBAnyTableViewCell {
    static var identifire: String {
        return String(describing: Self.self)
    }
}


// MARK: Concrete
public protocol LBTableViewCell: LBAnyTableViewCell {
    associatedtype ItemViewModel
    
    //var viewModel: ItemViewModel! { get } // For generic actions
    
    func setup(with viewModel: ItemViewModel)
}

public extension LBTableViewCell {
    func setupAny(with viewModel: LBItemViewModel) {
        guard let thisViewModel = viewModel as? ItemViewModel else {
            assertionFailure("setupAny(with:) take wrong argument. \(viewModel) - is not type of \(ItemViewModel.self)")
            return
        }
        
        setup(with: thisViewModel)
    }
    
    static func canSetup(by viewModelType: LBItemViewModel) -> Bool {
        return viewModelType is ItemViewModel
    }
}
