//
//  ItemDataSource.swift
//  MVVMCollection
//
//  Created by Alex on 14.08.22.
//

// MARK: Any Item DataSource
public protocol ItemDataSource {
    static var id: String { get }
}
extension ItemDataSource {
    public static var id: String { "\(Self.self)" }
}

public struct GeneralItemSource<VM>: ItemDataSource {
    let viewModel: VM
}
