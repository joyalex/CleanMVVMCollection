//
//  ItemViewModelWithAction.swift
//  MVVMCollection
//
//  Created by Alex on 18.08.22.
//

// MARK: - ViewModel + Actions

public protocol ItemViewModelWithAction: ItemViewModel {
    var actions: [ItemAction] { get }
}

// MARK: - Actions
public protocol ItemAction { }


// MARK: Tap

public protocol ItemTapAction: ItemAction {
    var handler: () -> Void { get }
}

public struct DefaultItemTapAction: ItemTapAction {
    public var handler: () -> Void
}


// MARK: SwipeAction
public protocol ItemTableSwipeAction: ItemAction {
    var title: String { get }
    var isLeading: Bool { get }
    var isDestructive: Bool { get }
    var typeName: String? { get }
    
    var handler: () -> Void { get } // add completion if need
}

public struct DefaultItemTableSwipeAction: ItemTableSwipeAction {
    public var title: String
    public var isLeading: Bool = false
    public var isDestructive: Bool = false
    public var typeName: String? = nil
    public var handler: () -> Void
}
