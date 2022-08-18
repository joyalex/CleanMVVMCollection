//
//  UITableView+TypeErasure.swift
//  MVVMCollection
//
//  Created by Alex on 07.08.22.
//

import UIKit

/// Пример с ранним связованием
/// Заменяемая ячейка зависит от конкретного DataSource
/// А за DataSource может быть любая ViewModel

// MARK: - Cell Type Erasure
public protocol AnyTableViewCell: UITableViewCell {
    static var identifire: String { get }
    
    func setupAny(with dataSource: ItemDataSource)
}

public protocol TableViewCell: AnyTableViewCell {
    associatedtype DataSource: ItemDataSource
    
    func setup(dataSource: DataSource)
}

public extension TableViewCell {
    static var identifire: String { DataSource.id }
    
    func setupAny(with dataSource: ItemDataSource) {
        guard let thisDataSource = dataSource as? DataSource else {
            assertionFailure("setupAny(with:) take wrong argument. \(dataSource) - is not type of \(DataSource.self)")
            return
        }
        setup(dataSource: thisDataSource)
    }
}
