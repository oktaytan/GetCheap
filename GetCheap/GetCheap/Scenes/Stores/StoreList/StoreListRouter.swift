//
//  StoreListRouter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class StoreListRouter: StoreListPresenterToRouterProtocol {
    
    weak var view: BaseViewController?
    
    init(view: BaseViewController) {
        self.view = view
    }
    
    static func createModule() -> BaseViewController {
        let view = StoreListVC(nibName: StoreListVC.className, bundle: nil)
        
        let service = APIService()
        let interactor = StoreListInteractor(service: service)
        let router = StoreListRouter(view: view)
        let presenter = StoreListPresenter(view: view, interactor: interactor, router: router)
        let provider = StoreListTableViewProviderImpl()
        
        interactor.presenter = presenter
        view.inject(presenter: presenter, provider: provider)
        
        return view
    }
    
    func navigate(_ route: StoreListRoute) {
        switch route {
        case .goToStore(let storeBanner, let storeID):
            goToStore(storeBanner: storeBanner, storeID: storeID)
        }
    }
}


extension StoreListRouter {
    private func goToStore(storeBanner: String, storeID: String) {
        let storeDetailVC = StoreDetailRouter.createModule(storeID: storeID, storeBanner: storeBanner)
        self.view?.navigationController?.pushViewController(storeDetailVC, animated: true)
    }
}
