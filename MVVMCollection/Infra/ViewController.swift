//
//  ViewController.swift
//  MVVMCollection
//
//  Created by Alex on 05.08.22.
//

import UIKit

/// Разводящий экран
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
    }
}

extension ViewController {
    func setupTabPresentation() {
        tabBarItem = UITabBarItem(
            title: "Empty",
            image: UIImage(systemName: "square"),
            selectedImage: UIImage(systemName: "square.fill")
        )
    }
}
