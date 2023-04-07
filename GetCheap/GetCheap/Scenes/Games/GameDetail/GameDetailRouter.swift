//
//  GameDetailRouter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import UIKit

final class GameDetailRouter: GameDetailPresenterToRouterProtocol {
    
    weak var view: BaseViewController?
    
    init(view: BaseViewController) {
        self.view = view
    }
    
    static func createModule(gameID: String) -> BaseViewController {
        let view = GameDetailVC(nibName: GameDetailVC.className, bundle: nil)
        
        let service = APIService()
        let interactor = GameDetailInteractor(gameID: gameID, service: service)
        let router = GameDetailRouter(view: view)
        let presenter = GameDetailPresenter(view: view, interactor: interactor, router: router)
        let provider = GameDetailTableViewProviderImpl()
        
        interactor.presenter = presenter
        view.inject(presenter: presenter, provider: provider)
        
        return view
    }
    
    func navigate(_ route: GameDetailRoute) {
        switch route {
        case .goToGameDeal(let dealID):
            goToDealDetail(dealID: dealID)
        }
    }
}


extension GameDetailRouter {
    private func goToDealDetail(dealID: String) {
        UIApplication.shared.goToDeal(dealID: dealID)
    }
}
