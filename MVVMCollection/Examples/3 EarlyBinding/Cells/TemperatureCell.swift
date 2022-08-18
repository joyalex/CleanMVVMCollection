//
//  TemperatureCell.swift
//  MVVMCollection
//
//  Created by Alex on 13.08.22.
//

import UIKit

// MARK:  View Model Layer
/// Плюс одна явная зависимость
/// Но она зашивается в Template
protocol TemperatureItemViewModel: ItemViewModel {
    var text: String { get }
}

extension TemperatureItemViewModel {
    func makeDataSource() -> ItemDataSource { GeneralItemSource(viewModel: self as TemperatureItemViewModel) }
}




// MARK:  View Layer
class TemperatureCell: UITableViewCell, TableViewCell {

    func setup(dataSource: GeneralItemSource<TemperatureItemViewModel>) {
        var content = UIListContentConfiguration.valueCell()
        content.text = dataSource.viewModel.text
        contentConfiguration = content
    }
}
