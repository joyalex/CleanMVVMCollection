//
//  Array+Extensions.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

extension Array {
    subscript(safe index: Index) -> Element? {
        guard index < endIndex else { return nil }
        guard index >= startIndex else { return nil }
        
        return self[index]
    }
}

