//
//  DealListRouter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import UIKit

final class DealListRouter: DealListPresenterToRouterProtocol {
    
    weak var view: BaseViewController?
    
    init(view: BaseViewController) {
        self.view = view
    }
    
    static func createModule() -> BaseViewController {
        let view = DealListVC(nibName: DealListVC.className, bundle: nil)
        
        let service = APIService()
        let interactor = DealListInteractor(service: service)
        let router = DealListRouter(view: view)
        let presenter = DealListPresenter(view: view, interactor: interactor, router: router)
        let provider = DealListTableViewProviderImpl()
        
        interactor.presenter = presenter
        view.inject(presenter: presenter, provider: provider)
        
        return view
    }
    
    func navigate(_ route: DealListRoute) {
        switch route {
        case .goToStore(let storeBanner, let storeID):
            goToStore(storeBanner: storeBanner, storeID: storeID)
        case .goToDealDetail(let dealID):
            goToDealDetail(dealID: dealID)
        }
    }
}


extension DealListRouter {
    private func goToStore(storeBanner: String, storeID: String) {
        let storeDetailVC = StoreDetailRouter.createModule(storeID: storeID, storeBanner: storeBanner)
        self.view?.navigationController?.pushViewController(storeDetailVC, animated: true)
    }
    
    private func goToDealDetail(dealID: String) {
        UIApplication.shared.goToDeal(dealID: dealID)
    }
}
