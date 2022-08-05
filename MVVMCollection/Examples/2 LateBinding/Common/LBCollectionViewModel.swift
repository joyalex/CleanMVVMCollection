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


// MARK: - ViewModel + Actions

public protocol LBItemViewModelWithAction: LBItemViewModel {
    var actions: [LBItemAction] { get }
}

// MARK: Actions
public protocol LBItemAction { }

public protocol LBItemItemTapAction: LBItemAction {
    var handler: () -> Void { get }
}

public protocol LBItemTableSwipeAction: LBItemAction {
    var title: String { get }
    var isLeading: Bool { get }
    var isDestructive: Bool { get }
    var typeName: String? { get }
    
    var handler: () -> Void { get } // add completion if need
}

public struct LBDefaultItemTableSwipeAction: LBItemTableSwipeAction {
    public var title: String
    public var isLeading: Bool = false
    public var isDestructive: Bool = false
    public var typeName: String? = nil
    public var handler: () -> Void
}

public struct LBDefaultItemTapAction: LBItemItemTapAction {
    public var handler: () -> Void
}
