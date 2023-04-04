//
//  MainTabBarPresenter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation


final class MainTabBarPresenter: TabBarViewToPresenterProtocol {
  
    var view: TabBarPresenterToViewProtocol?
    var interactor: TabBarPresenterToInteractorProtocol?
    var router: TabBarPresenterToRouterProtocol?
    
    init(view: TabBarPresenterToViewProtocol?,
         interactor: TabBarPresenterToInteractorProtocol?,
         router: TabBarPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router =  router
    }
    
    func load() {
        interactor?.load()
        self.view?.handleOutput(.loaders(TabItemType.allCases))
    }
    
    func checkConnection() {
        interactor?.checkConnection()
    }
}


extension MainTabBarPresenter: TabBarInteractorToPresenterProtocol {
    func handleOutput(_ output: TabBarInteractorOutput) {
        switch output {
        case .networkReachability(let status):
            self.view?.handleOutput(.networkReachability(status))
        }
    }
}
