//
//  LateBindingDelegate.swift
//  MVVMCollection
//
//  Created by Alex on 14.08.22.
//

import UIKit

class LateBindingDelegate: NSObject {
    private var viewModel: LBCollectionViewModel
    
    init(viewModel: LBCollectionViewModel) {
        self.viewModel = viewModel
    }
}

extension LateBindingDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let itemViewModel = viewModel.getItem(for: indexPath) as? LBItemViewModelWithAction else { return }
        
        itemViewModel
            .actions
            .compactMap { $0 as? LBItemItemTapAction }
            .forEach { $0.handler() }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let itemViewModel = viewModel.getItem(for: indexPath) as? LBItemViewModelWithAction else {
            return nil
        }
            
        let actions = itemViewModel
            .actions
            .compactMap { $0 as? LBItemTableSwipeAction }
            .filter { $0.isLeading }
            .map { vmAction -> UIContextualAction in
            
                let action = UIContextualAction(style: .normal, title: vmAction.title) { cellAction, view, completion in
                    vmAction.handler()
                    completion(true)
                }
                action.backgroundColor = vmAction.typeName.map { UIColor(named: $0) } ?? .systemGray6
                
                return action
            }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let itemViewModel = viewModel.getItem(for: indexPath) as? LBItemViewModelWithAction else {
            return nil
        }
            
        let actions = itemViewModel
            .actions
            .compactMap { $0 as? LBItemTableSwipeAction }
            .filter { !$0.isLeading }
            .map { vmAction -> UIContextualAction in
            
                let action = UIContextualAction(style: .normal, title: vmAction.title) { cellAction, view, completion in
                    vmAction.handler()
                    completion(true)
                }
                action.backgroundColor = vmAction.typeName.map { UIColor(named: $0) } ?? .systemGray6
                
                return action
            }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}
