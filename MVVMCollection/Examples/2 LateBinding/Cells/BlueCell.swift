//
//  BlueCell.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

import UIKit

final class BlueCell: OneTitleCell, LBTableViewCell {
    var viewModel: ColdItemViewModel!

    func setup(with viewModel: ColdItemViewModel) {
        self.viewModel = viewModel
        // тут можно подписаться на publish свойства ViewModel и обновлять контент без reloadData()
        
        /// Далее мы сетапим ячейку данными
        /// При создании или переиспользовании
        
        setupWith(title: viewModel.coldness)
        backgroundColor = .blue.withAlphaComponent(0.5)
    }
}
