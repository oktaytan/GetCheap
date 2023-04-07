//
//  GameDetailPresenter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import Foundation

final class GameDetailPresenter: GameDetailViewToPresenterProtocol {
    
    var view: GameDetailPresenterToViewProtocol?
    var interactor: GameDetailPresenterToInteractorProtocol?
    var router: GameDetailPresenterToRouterProtocol?
    
    private var sections = [GameDetailPresenterOutput.SectionType]()
    
    init(view: GameDetailPresenterToViewProtocol?,
         interactor: GameDetailPresenterToInteractorProtocol?,
         router: GameDetailPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func load() {
        interactor?.load()
    }
    
    func goToGameDeal(dealID: String) {
        router?.navigate(.goToGameDeal(dealID: dealID))
    }
}

extension GameDetailPresenter {
    private func prepare(_ data: GameLookup) {
        sections.removeAll()
        
        let detail = GameDetailEntity(data)
        
        sections.append(.head(banner: detail.thumbnail, title: detail.name))
        sections.append(.detail(releaseDate: detail.date, salePrice: detail.price))
        
        if !detail.deals.isEmpty {
            sections.append(.deals(rows: detail.deals.map({ .deal($0) })))
        }
        
        view?.handleOutput(.load(sections))
    }
}

extension GameDetailPresenter: GameDetailInteractorToPresenterProtocol {
    func handleOutput(_ output: GameDetailInteractorOutput) {
        switch output {
        case .load(let data):
            prepare(data)
        case .showLoading(let show):
            view?.handleOutput(.showLoading(show))
        case .showError(let error):
            view?.handleOutput(.showError(error))
        }
    }
}
