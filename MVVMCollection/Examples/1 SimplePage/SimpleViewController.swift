//
//  SimplePageViewController.swift
//  MVVMCollection
//
//  Created by Alex on 05.08.22.
//

import UIKit
import SnapKit

class SimplePageViewController: UIViewController {
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    private var viewModel: SimplePageViewModel
    
    init(viewModel: SimplePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupTabPresentation()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SimplePageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.backgroundColor = .systemMint
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        renderByViewModel()
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
}

// MARK: - Render
extension SimplePageViewController {
    func renderByViewModel() {
        titleLabel.text = viewModel.titleText
        dateLabel.text = viewModel.dateText
    }
}

// MARK: - TabBar
extension SimplePageViewController {
    func setupTabPresentation() {
        tabBarItem = UITabBarItem(
            title: "Simple",
            image: UIImage(systemName: "circle"),
            selectedImage: UIImage(systemName: "circle.fill")
        )
    }
}
