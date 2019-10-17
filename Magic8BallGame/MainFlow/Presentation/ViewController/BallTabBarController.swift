//
//  BallTabBarController.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 17.10.2019.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class BallTabBarController: UITabBarController {

    private let ballViewModel: BallViewModel!

    init(ballViewModel: BallViewModel) {
        self.ballViewModel = ballViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavigationController()
        configureTabBarController()
    }

    // MARK: - Configure Tab Bar Controller

    private func configureTabBarController() {
        let firstViewController = BallViewController(ballViewModel: ballViewModel)
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let secondViewController = BallStorageViewController(ballViewModel: ballViewModel)
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
    }
}

extension BallTabBarController {

    // MARK: Setup Navigation Bar

    private func setupCustomNavigationController() {
        let nav = self.navigationController?.navigationBar

        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit

        let image = Asset._8.image
        imageView.image = image

        navigationItem.titleView = imageView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: L10n.wait,
                                                                      style: .done,
                                                                      target: self,
                                                                      action: #selector(self.action(sender:)))
    }

    @objc
    private func action(sender: UIBarButtonItem) {
        let optionsVC = BallOptionsViewController(ballOptionsViewModel: BallOptionsViewModel(model: BallOptionsModel(
            hardAnswersStorage: DataAnswer())))
        self.navigationController?.pushViewController(optionsVC, animated: true)
    }
}
