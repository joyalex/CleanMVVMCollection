//
//  EarlyBindingViewModel.swift
//  MVVMCollection
//
//  Created by Alex on 13.08.22.
//

protocol BlackWhiteViewModel: CollectionViewModel { }

extension CollectionDomainModel: BlackWhiteViewModel {
    var itemSections: [SectionViewModel] { [DefaultSectionViewModel(items: samples)] }
}

extension SimpleDomainModel: TemperatureItemViewModel {
    var text: String { "\(value)" }
}
