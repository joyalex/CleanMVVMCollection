//
//  CollectionDomainModel.swift
//  MVVMCollection
//
//  Created by Alex on 07.08.22.
//

import Foundation

struct CollectionDomainModel {
    var name: String
    var uid = UUID()
    
    var samples: [SimpleDomainModel] = (0..<100).map { SimpleDomainModel(value: Float($0)/Float(100) ) }
}
