//
//  DistanceCell.swift
//  MVVMCollection
//
//  Created by Alex on 18.08.22.
//

import UIKit

protocol DistanceItemViewModel: ItemViewModel {
    var title: String { get }
    var value: Float { get }
}

extension DistanceItemViewModel {
    func makeDataSource() -> ItemDataSource { GeneralItemSource(viewModel: self as DistanceItemViewModel) }
}


final class DistanceCell: BaseTableCell<DistanceItemViewModel> {
    
    override func setup(by viewModel: DistanceItemViewModel) {
        super.setup(by: viewModel)
        
        var content = UIListContentConfiguration.subtitleCell()
        content.text = viewModel.title
        content.secondaryText = drawProgressBar(by: viewModel.value)

        contentConfiguration = content
    }
    
    private func drawProgressBar(by value: Float) -> String {
        let count = Int(min(max(value, 0), 1) * 10)

        let lingth = Array<String>(repeating: "-", count: count).joined(separator: "")
        return "|\(lingth)|"
    }
}
