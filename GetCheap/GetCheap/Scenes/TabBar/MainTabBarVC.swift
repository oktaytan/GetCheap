//
//  MainTabBarVC.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import UIKit
import SPIndicator

class MainTabBarVC: BaseTabBarController {
    
    var presenter: TabBarViewToPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        UITabBar.appearance().isTranslucent = true
        tabBar.tintColor = .blueSoft
    }

    private func createNavController(for item: TabItemType) -> BaseNavigationController {
        let navController = BaseNavigationController(rootViewController: item.vc)
        navController.tabBarItem.title = item.title
        navController.tabBarItem.image = item.icon
        navController.tabBarItem.selectedImage = item.selectedIcon
        return navController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        presenter.checkConnection()
    }
}


extension MainTabBarVC {
    private func setupVCs(_ items: [TabItemType]) {
        self.viewControllers = items.map { createNavController(for: $0) }
    }
}


extension MainTabBarVC: TabBarPresenterToViewProtocol {
    func handleOutput(_ output: TabBarPresenterOutput) {
        switch output {
        case .loaders(let items):
            self.setupVCs(items)
        case .networkReachability(let status):
            switch status {
            case .hasConnection:
                break
            case .noConnection:
                showAlert(title: AppConstants.APP_TITLE, message: status.rawValue)
            }
        }
    }
}
