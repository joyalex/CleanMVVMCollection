//
//  CollectionDelegate.swift
//  MVVMCollection
//
//  Created by Alex on 18.08.22.
//

import UIKit


class CollectionDelegate: NSObject {
    private var viewModel: CollectionViewModel
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
    }
}

extension CollectionDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let itemViewModel = viewModel.getItem(for: indexPath) as? ItemViewModelWithAction else { return }
        
        itemViewModel
            .actions
            .compactMap { $0 as? ItemTapAction }
            .forEach { $0.handler() }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let itemViewModel = viewModel.getItem(for: indexPath) as? ItemViewModelWithAction else {
            return nil
        }
            
        let actions = itemViewModel
            .actions
            .compactMap { $0 as? ItemTableSwipeAction }
            .filter { $0.isLeading }
            .map { vmAction -> UIContextualAction in
            
                let action = UIContextualAction(style: .normal, title: vmAction.title) { cellAction, view, completion in
                    vmAction.handler()
                    completion(true)
                }
                action.backgroundColor = vmAction.typeName.map { UIColor(named: $0) } ?? .systemGray2
                
                return action
            }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let itemViewModel = viewModel.getItem(for: indexPath) as? ItemViewModelWithAction else {
            return nil
        }
            
        let actions = itemViewModel
            .actions
            .compactMap { $0 as? ItemTableSwipeAction }
            .filter { !$0.isLeading }
            .map { vmAction -> UIContextualAction in
            
                let action = UIContextualAction(style: .normal, title: vmAction.title) { cellAction, view, completion in
                    vmAction.handler()
                    completion(true)
                }
                action.backgroundColor = vmAction.typeName.map { UIColor(named: $0) } ?? .systemGray2
                
                return action
            }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}

// MARK: Header/Footer UITableViewDataSource
extension CollectionDelegate {

}

// MARK: - Helpers

extension CollectionViewModel {
    func getItem(for indexPath: IndexPath) -> ItemViewModel? {
        itemSections[safe: indexPath.section]?.items[safe: indexPath.row]
    }
}
