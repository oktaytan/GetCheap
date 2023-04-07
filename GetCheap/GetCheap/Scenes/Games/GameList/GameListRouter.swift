//
//  GameListRouter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class GameListRouter: GameListPresenterToRouterProtocol {
    
    weak var view: BaseViewController?
    
    init(view: BaseViewController) {
        self.view = view
    }
    
    static func createModule() -> BaseViewController {
        let view = GameListVC(nibName: GameListVC.className, bundle: nil)
        
        let service = APIService()
        let interactor = GameListInteractor(service: service)
        let router = GameListRouter(view: view)
        let presenter = GameListPresenter(view: view, interactor: interactor, router: router)
        let provider = GameListTableViewProviderImpl()
        
        interactor.presenter = presenter
        view.inject(presenter: presenter, provider: provider)
        
        return view
    }
    
    func navigate(_ route: GameListRoute) {
        switch route {
        case .goToGameDetail(let gameID):
            goToGameDetail(gameID: gameID)
        }
    }
}


extension GameListRouter {
    private func goToGameDetail(gameID: String) {
        let gameDetailVC = GameDetailRouter.createModule(gameID: gameID)
        view?.navigationController?.pushViewController(gameDetailVC, animated: true)
    }
}
