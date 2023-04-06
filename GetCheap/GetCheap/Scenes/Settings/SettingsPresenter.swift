//
//  SettingsPresenter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class SettingsPresenter: SettingsViewToPresenterProtocol {
    
    var view: SettingsPresenterToViewProtocol?
    var interactor: SettingsPresenterToInteractorProtocol?
    var router: SettingsPresenterToRouterProtocol?
    
    
    init(view: SettingsPresenterToViewProtocol?,
         interactor: SettingsPresenterToInteractorProtocol?,
         router: SettingsPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func load() {
        interactor?.load()
    }
}

extension SettingsPresenter: SettingsInteractorToPresenterProtocol {
    func handleOutput(_ output: SettingsInteractorOutput) {
        
    }
}
