//
//  MainTabBarRouter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

final class MainTabBarRouter: TabBarPresenterToRouterProtocol {
    
    static func createModule() -> BaseTabBarController {
        let tabBar = MainTabBarVC(nibName: MainTabBarVC.className, bundle: nil)
        let reachability = try! Reachability()
        let interactor = MainTabBarInteractor(reachability: reachability)
        let router = MainTabBarRouter()
        let presenter = MainTabBarPresenter(view: tabBar, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        tabBar.presenter = presenter
        
        presenter.load()
        
        return tabBar
    }
    
}
