//
//  LBItemViewModelWithAction.swift
//  MVVMCollection
//
//  Created by Alex on 18.08.22.
//

// MARK: - ViewModel + Actions

public protocol LBItemViewModelWithAction: LBItemViewModel {
    var actions: [LBItemAction] { get }
}

// MARK: - Actions
public protocol LBItemAction { }


// MARK: Tap

public protocol LBItemItemTapAction: LBItemAction {
    var handler: () -> Void { get }
}

public struct LBDefaultItemTapAction: LBItemItemTapAction {
    public var handler: () -> Void
}


// MARK: SwipeAction
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
