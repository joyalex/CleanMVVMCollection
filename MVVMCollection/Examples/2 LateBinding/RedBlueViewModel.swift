//
//  RedBlueViewModel.swift
//  MVVMCollection
//
//  Created by Alex on 11.08.22.
//

protocol RedBlueViewModel: LBCollectionViewModel {
    // func doCommonAction()
    // func select()
    // func rearange()
}

// MARK: - Простейшая реализация cписка

extension CollectionDomainModel: RedBlueViewModel {
    var sections: [LBSectionViewModel] {
        [LBDefaultSectionViewModel(items: samples)]
    }
}

extension SimpleDomainModel: LBItemViewModel { }









// MARK: - Более сложная

struct RedBlueViewModelImpl: RedBlueViewModel {
    let model: CollectionDomainModel
    var sections: [LBSectionViewModel]
    
    init(model: CollectionDomainModel) {
        self.model = model
        
        self.sections = model.groupedSamples.map { (key, samples) in
            
            var items: [LBItemViewModel]
            if key == "Height" {
                items = samples.map { HotItemViewModelWrapper(model: $0) }
            } else {
                items = samples.map { ColdItemViewModelWrapper(model: $0) }
            }
            
            return LBDefaultHeadedFooterSectionViewModel(
                header: key,
                items: items
            )
        }
    }
}

extension CollectionDomainModel {
    fileprivate var groupedSamples: [(String, [SimpleDomainModel])] {
        Dictionary(grouping: samples) { sample in
            switch sample.value {
            case 0..<0.2:
                return "Low"
            case 0.2..<0.8:
                return "Meddium"
            case 0.8...1:
                return "Height"
            default:
                return "Unknown"
            }
        }
        .map { ($0.key, $0.value) }
        .sorted { $0.0 < $1.0 }
    }
}

// MARK: Item ViewModels

protocol HotItemViewModel: LBItemViewModel {
    var hotness: String { get }
}

protocol ColdItemViewModel: LBItemViewModel {
    var coldness: String { get }
}

struct HotItemViewModelWrapper: HotItemViewModel {
    var model: SimpleDomainModel
    var hotness: String { String(format: "The hotness: \(model.value)") }
}

struct ColdItemViewModelWrapper: ColdItemViewModel {
    let model: SimpleDomainModel
    var coldness: String { String(format: "The coldness: \(model.value)") }
}



// MARK: - ViewModel + Actions
extension HotItemViewModelWrapper: LBItemViewModelWithAction {
    var actions: [LBItemAction] {
        let edit = LBDefaultItemTableSwipeAction(title: "Edit", typeName: "Medium") {
            print("Start edit")
        }
        
        let log = LBDefaultItemTableSwipeAction(title: "Log", typeName: "Cold") {
            print("Start Log")
        }
        
        let tap = LBDefaultItemTapAction {
            print("Did tap on Hot \(model)")
        }
        return [edit, log, tap]
    }
}

extension ColdItemViewModelWrapper: LBItemViewModelWithAction {
    var actions: [LBItemAction] {
        let tap = LBDefaultItemTapAction {
            print("Did tap on Cold \(model)")
        }
        return [tap]
    }
}
