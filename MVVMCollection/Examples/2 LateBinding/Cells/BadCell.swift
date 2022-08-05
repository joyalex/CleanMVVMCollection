//
//  BadCell.swift
//  MVVMCollection
//
//  Created by Alex on 13.08.22.
//

import UIKit

/// Это пример обобщенной ячейки
public class OneTitleCell: UITableViewCell {
    
    public func setupWith(title: String) {
        var content = UIListContentConfiguration.valueCell()
        content.text = title
        contentConfiguration = content
    }
}


class BadCell: OneTitleCell {}

extension BadCell: LBTableViewCell {
    func setup(with viewModel: SimpleDomainModel) {

        /// Далее мы сетапим ячейку данными
        /// При создании или переиспользовании
        
        setupWith(title: "\(viewModel.value)")
        backgroundColor = .gray.withAlphaComponent(0.5)
    }
}
