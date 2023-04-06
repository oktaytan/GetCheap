//
//  SettingsRouter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class SettingsRouter: SettingsPresenterToRouterProtocol {
    
    static func createModule() -> BaseViewController {
        let view = SettingsVC(nibName: SettingsVC.className, bundle: nil)
        
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(view: view, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
    }
    
    func navigate(_ route: SettingsRoute) {
        
    }
}
