//
//  DealListPresenter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import Foundation

final class DealListPresenter: DealListViewToPresenterProtocol {
    
    var view: DealListPresenterToViewProtocol?
    var interactor: DealListPresenterToInteractorProtocol?
    var router: DealListPresenterToRouterProtocol?
    
    private var deals = [DealListEntity]()
    private var rows = [DealListPresenterOutput.RowType]()
    
    init(view: DealListPresenterToViewProtocol?,
         interactor: DealListPresenterToInteractorProtocol?,
         router: DealListPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func load() {
        interactor?.load()
    }
    
    private func prepare(_ data: [Store: [Deal]]) {
        self.rows.removeAll()
        self.deals = data.map({ DealListEntity(store: $0.key, dealList: $0.value) })
        
        guard !self.deals.isEmpty else {
            self.rows.append(.empty)
            self.view?.handleOutput(.load(self.rows))
            return
        }
        
        self.rows = self.deals.map({ .deal($0) })
        self.view?.handleOutput(.load(self.rows))
    }
    
    func goToStore(storeBanner: String, storeID: String) {
        router?.navigate(.goToStore(storeBanner: storeBanner, storeID: storeID))
    }
    
    func goToDealDetail(dealID: String) {
        router?.navigate(.goToDealDetail(dealID: dealID))
    }
}

extension DealListPresenter: DealListInteractorToPresenterProtocol {
    func handleOutput(_ output: DealListInteractorOutput) {
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
