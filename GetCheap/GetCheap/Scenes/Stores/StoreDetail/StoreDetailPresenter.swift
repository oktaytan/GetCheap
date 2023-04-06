//
//  StoreDetailPresenter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class StoreDetailPresenter: StoreDetailViewToPresenterProtocol {
    
    var view: StoreDetailPresenterToViewProtocol?
    var interactor: StoreDetailPresenterToInteractorProtocol?
    var router: StoreDetailPresenterToRouterProtocol?
    
    private var data: StoreDetailEntity?
    private var rows = [StoreDetailPresenterOutput.ItemType]()
    
    init(view: StoreDetailPresenterToViewProtocol?,
         interactor: StoreDetailPresenterToInteractorProtocol?,
         router: StoreDetailPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func load() {
        interactor?.load()
    }
    
    private func prepare(banner: String, deals: [Deal]) {
        self.rows.removeAll()
        self.data = StoreDetailEntity(banner: banner, dealList: deals)
        
        guard !deals.isEmpty else {
            self.rows.append(.empty)
            self.view?.handleOutput(.load(banner: banner, deals: self.rows))
            return
        }
        
        self.rows = deals.map({ .deals(DealEntity($0)) })
        self.view?.handleOutput(.load(banner: banner, deals: self.rows))
    }
    
    func goToDealDetail(dealID: String) {
        router?.navigate(.goToDealDetail(dealID: dealID))
    }
}

extension StoreDetailPresenter: StoreDetailInteractorToPresenterProtocol {
    func handleOutput(_ output: StoreDetailInteractorOutput) {
        switch output {
        case .data(let banner, let deals):
            self.prepare(banner: banner, deals: deals)
        case .showLoading(let show):
            view?.handleOutput(.showLoading(show))
        case .showError(let error):
            view?.handleOutput(.showError(error))
        }
    }
}
