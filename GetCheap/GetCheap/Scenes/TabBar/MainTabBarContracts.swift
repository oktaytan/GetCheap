//
//  MainTabBarContracts.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation


// MARK: - VIEW
protocol TabBarViewToPresenterProtocol: AnyObject {
    var view: TabBarPresenterToViewProtocol? { get set }
    var interactor: TabBarPresenterToInteractorProtocol? { get set }
    var router: TabBarPresenterToRouterProtocol? { get set }
    
    func load()
    func checkConnection()
}


// MARK: - INTERACTOR
protocol TabBarPresenterToInteractorProtocol: AnyObject {
    var presenter: TabBarInteractorToPresenterProtocol? { get set }
    var reachability: Reachability { get set }
    
    func load()
    func checkConnection()
}

enum TabBarInteractorOutput {
    case networkNotReachable
}

protocol TabBarInteractorToPresenterProtocol: AnyObject {
    func handleOutput(_ output: TabBarInteractorOutput)
}


// MARK: - PRESENTER
enum TabBarPresenterOutput {
    case loaders([TabItemType]), networkNotReachable
}

protocol TabBarPresenterToViewProtocol: AnyObject {
    func handleOutput(_ output: TabBarPresenterOutput)
}


// MARK: - ROUTER
protocol TabBarPresenterToRouterProtocol: AnyObject {
    static func createModule() -> BaseTabBarController
}
