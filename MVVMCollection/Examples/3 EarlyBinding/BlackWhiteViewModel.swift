//
//  EarlyBindingViewModel.swift
//  MVVMCollection
//
//  Created by Alex on 13.08.22.
//

// MARK: - Easy Way

protocol BlackWhiteViewModel: CollectionViewModel { }

extension CollectionDomainModel: BlackWhiteViewModel {
    var itemSections: [SectionViewModel] { [DefaultSectionViewModel(items: samples)] }
}


// Item View model
extension SimpleDomainModel: TemperatureItemViewModel {
    var text: String { "t = \((value * 100).rounded()) ºC" }
}

extension SimpleDomainModel: ItemViewModelWithAction {
    var actions: [ItemAction] {
        [DefaultItemTapAction { print(" 1 SimpleDomainModel \(value) did selected") },
         DefaultItemTableSwipeAction(title: "Swipe", handler: { print(" 2 SimpleDomainModel \(value) did Swipeed") }) ]
    }
}


// MARK: - Medium Way

final class BlackWhiteViewModelImpl: BlackWhiteViewModel {
    var itemSections: [SectionViewModel]
    
    private let model: CollectionDomainModel
    
    init(_ model: CollectionDomainModel) {
        self.model = model
        
        let items = model.samples.map { DistanceItemViewModelImpl($0) }
        let section = DefaultHeadedItemSectionViewModel(header: "Distances", items: items)
        
        self.itemSections = [section]
    }
}

// Item View model
struct DistanceItemViewModelImpl: DistanceItemViewModel {
    var title: String { "t = \((model.value * 100).rounded()) mm" }
    var value: Float { model.value }
    
    private let model: SimpleDomainModel
    
    init(_ model: SimpleDomainModel) {
        self.model = model
    }
}

extension DistanceItemViewModelImpl: ItemViewModelWithAction {
    var actions: [ItemAction] {
        [
            DefaultItemTapAction { print(" 1 DistanceItemViewModelImpl \(value) did selected") },
            DefaultItemTableSwipeAction(
                title: "Swipe",
                isLeading: true,
                handler: { print(" 2 DistanceItemViewModelImpl \(value) did Swipeed") })
        ]
    }
}
