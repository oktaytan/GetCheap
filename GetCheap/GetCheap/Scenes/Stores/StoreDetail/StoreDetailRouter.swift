//
//  StoreDetailRouter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

final class StoreDetailRouter: StoreDetailPresenterToRouterProtocol {
    
    static func createModule(storeID: String, storeBanner: String) -> BaseViewController {
        let view = StoreDetailVC(nibName: StoreDetailVC.className, bundle: nil)
        
        let service = APIService()
        let interactor = StoreDetailInteractor(storeID: storeID, storeBanner: storeBanner, service: service)
        let router = StoreDetailRouter()
        let presenter = StoreDetailPresenter(view: view, interactor: interactor, router: router)
        let provider = StoreDetailCollectionViewProviderImpl()
        
        interactor.presenter = presenter
        view.inject(presenter: presenter, provider: provider)
        
        return view
    }
    
    func navigate(_ route: StoreDetailRoute) {
        switch route {
        case .goToDealDetail(let dealID):
            goToDealDetail(dealID: dealID)
        }
    }
}


extension StoreDetailRouter {
    private func goToDealDetail(dealID: String) {
        guard let url = URL(string: "https://\(AppConstants.SERVICE_HOST)/redirect?dealID=\(dealID)") else { return }
        UIApplication.shared.open(url)
    }
}
