//
//  LBCollectionViewModel.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

/// Несмотря на то, что таблички очень похожи друг на друга
/// Этот протокол нельзя седалть одноверменно и удобным и универсальным для всех
///
/// Специфика приложения, состав и привычки команды влияют на то, что именно ожидается от
/// "удобного интерфейса", помимо объективных принципов (SOLID, DRY, KISS)
/// Такие ограничения можно назвать гипперпараметрами для принятия архитекрного решения
public protocol LBCollectionViewModel {
    var sections: [LBSectionViewModel] { get }
}

public protocol LBSectionViewModel {
    var items: [LBItemViewModel] { get }
}

public protocol LBHeadedFooterSectionViewModel: LBSectionViewModel {
    var header: String? { get }
    var footer: String? { get }
}


// MARK: Any Item ViewModel
public protocol LBItemViewModel { }

// MARK: - Default Impl

public struct LBDefaultSectionViewModel: LBSectionViewModel {
    public var items: [LBItemViewModel]
}

public struct LBDefaultHeadedFooterSectionViewModel: LBHeadedFooterSectionViewModel {
    public var header: String?
    public var footer: String?
    
    public var items: [LBItemViewModel]
}
