//
//  SpreadingViewController.swift
//  MVVMCollection
//
//  Created by Alex on 06.08.22.
//

import UIKit

class SpreadingViewController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let simpleVC = PresentationFactory.makeSimplePageViewController()
        let lateVC = PresentationFactory.makeLateBindingController()
        let earlyVC = PresentationFactory.makeSpecificTableViewController()
        
        self.setViewControllers([simpleVC, lateVC, earlyVC], animated: false)
    }
}

extension SpreadingViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}


/// Presentation Factory
///

enum PresentationFactory {
    static func makeSimplePageViewController() -> SimplePageViewController {
        let model = SimpleDomainModel()
        
        let viewModel = model // FormatedSimplePageViewModelImpl(model: model)
        
        return SimplePageViewController(viewModel: viewModel)
    }
    
    static func makeLateBindingController() -> UIViewController {
        let model = CollectionDomainModel(name: "LateBinding model")
        
        let viewModel = RedBlueViewModelImpl(model: model)
        
        return UINavigationController(rootViewController: RedBlueViewController(viewModel: viewModel))
    }
    
    static func makeSpecificTableViewController() -> UINavigationController {
        let model = CollectionDomainModel(name: "First model")

        let viewModel = model

        return UINavigationController(rootViewController: BlackWhiteViewController(viewModel: viewModel))
    }
}
