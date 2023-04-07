//
//  GameListPresenter.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class GameListPresenter: GameListViewToPresenterProtocol {
    
    var view: GameListPresenterToViewProtocol?
    var interactor: GameListPresenterToInteractorProtocol?
    var router: GameListPresenterToRouterProtocol?
    
    private var gameList = [GameEntity]()
    private var popularSections = [GameListPresenterOutput.SectionType]()
    private var searchSections = [GameListPresenterOutput.SectionType]()
    
    init(view: GameListPresenterToViewProtocol?,
         interactor: GameListPresenterToInteractorProtocol?,
         router: GameListPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func load() {
        interactor?.popular(gameIDs: AppConstants.POPULAR_GAME_IDs)
    }
    
    func search(title: String) {
        interactor?.search(title: title)
    }
    
    func popular() {
        self.view?.handleOutput(.load(popularSections))
    }
    
    func goToGameDetail(gameID: String) {
        router?.navigate(.goToGameDetail(gameID: gameID))
    }
}


extension GameListPresenter {
    private func preparePupularData(_ data: [MultipleGameItem]) {
        popularSections.removeAll()
        
        popularSections.append(.header(AppConstants.GAME_LIST_HEADER_TEXT))
        var rows = [GameListPresenterOutput.RowType]()
        
        data.forEach { anyData in
            guard let entity = GameEntity.setData(anyData) else { return }
            rows.append(.game(entity))
        }
        
        popularSections.append(.list(rows: rows, header: "Popular games"))
        
        popular()
    }
    
    private func prepareSearchData(_ data: [Game]) {
        self.gameList.removeAll()
        searchSections.removeAll()
        
        guard !data.isEmpty else {
            searchSections.append(.list(rows: [GameListPresenterOutput.RowType.empty], header: "No result"))
            self.view?.handleOutput(.load(searchSections))
            return
        }
        
        data.forEach { anyData in
            guard let entity = GameEntity.setData(anyData) else { return }
            self.gameList.append(entity)
        }
        
        let rowHeader: String = self.gameList.count > 0 ? "Search results" : "Search result"
        let rows = self.gameList.map({ GameListPresenterOutput.RowType.game($0) })
        searchSections.append(.list(rows: rows, header: rowHeader))
        self.view?.handleOutput(.load(searchSections))
    }
}


extension GameListPresenter: GameListInteractorToPresenterProtocol {
    func handleOutput(_ output: GameListInteractorOutput) {
        switch output {
        case .popular(let data):
            preparePupularData(data)
        case .search(let data):
            prepareSearchData(data)
        case .showLoading(let show):
            view?.handleOutput(.showLoading(show))
        case .showError(let error):
            view?.handleOutput(.showError(error))
        }
    }
}
