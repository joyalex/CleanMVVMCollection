//
//  RedCell.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

import UIKit

/// Конкретная ячейка
final class RedCell: OneTitleCell, LBTableViewCell {
    var viewModel: HotItemViewModel!

    func setup(with viewModel: HotItemViewModel) {
        self.viewModel = viewModel
        // тут можно подписаться на publish свойства ViewModel и обновлять контент без reloadData()
        
        /// Далее мы сетапим ячейку данными
        /// При создании или переиспользовании
        
        setupWith(title: viewModel.hotness)
        backgroundColor = .red.withAlphaComponent(0.5)
    }
}
