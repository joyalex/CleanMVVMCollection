//
//  CollectionViewModel.swift
//  MVVMCollection
//
//  Created by Alex on 07.08.22.
//

/// Несмотря на то, что таблички очень похожи друг на друга
/// Этот протокол нельзя седалть одноверменно и удобным и универсальным для всех
///
/// Специфика приложения, состав и привычки команды влияют на то, что именно ожидается от
/// "удобного интерфейса", помимо объективных принципов (SOLID, DRY, KISS)
/// Такие ограничения можно назвать гипперпараметрами для принятия архитекрного решения
public protocol CollectionViewModel {
    var itemSections: [SectionViewModel] { get }
}

public protocol SectionViewModel {
    var items: [ItemViewModel] { get }
}

public protocol HeadedItemGroupViewModel: SectionViewModel {
    var header: String? { get }
    var footer: String? { get }
}


// MARK: Any Item ViewModel
public protocol ItemViewModel {
    func makeDataSource() -> ItemDataSource
}

// MARK: - Helpers

public struct DefaultSectionViewModel: SectionViewModel {
    public var items: [ItemViewModel]
}

public struct DefaultHeadedItemSectionViewModel: HeadedItemGroupViewModel {
    public var header: String?
    public var footer: String?
    
    public var items: [ItemViewModel]
}
