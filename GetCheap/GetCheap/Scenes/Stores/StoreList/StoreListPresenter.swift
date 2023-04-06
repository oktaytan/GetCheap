//
//  StoreListPresenter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class StoreListPresenter: StoreListViewToPresenterProtocol {
    
    var view: StoreListPresenterToViewProtocol?
    var interactor: StoreListPresenterToInteractorProtocol?
    var router: StoreListPresenterToRouterProtocol?
    
    private var deals = [StoreListEntity]()
    private var rows = [StoreListPresenterOutput.RowType]()
    
    init(view: StoreListPresenterToViewProtocol?,
         interactor: StoreListPresenterToInteractorProtocol?,
         router: StoreListPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func load() {
        interactor?.load()
    }
    
    private func prepare(_ data: [Store]) {
        self.rows.removeAll()
        self.deals = data.map(StoreListEntity.init)
        
        guard !self.deals.isEmpty else {
            self.rows.append(.empty)
            self.view?.handleOutput(.load(self.rows))
            return
        }
        
        self.rows = self.deals.map({ .store($0) })
        self.view?.handleOutput(.load(self.rows))
    }
    
    func goToStore(storeBanner: String, storeID: String) {
        router?.navigate(.goToStore(storeBanner: storeBanner, storeID: storeID))
    }
}

extension StoreListPresenter: StoreListInteractorToPresenterProtocol {
    func handleOutput(_ output: StoreListInteractorOutput) {
        switch output {
        case .data(let data):
            self.prepare(data)
        case .showLoading(let show):
            view?.handleOutput(.showLoading(show))
        case .showError(let error):
            view?.handleOutput(.showError(error))
        }
    }
}
