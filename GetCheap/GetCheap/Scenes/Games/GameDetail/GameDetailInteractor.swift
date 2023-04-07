//
//  GameDetailInteractor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import Foundation

final class GameDetailInteractor: GameDetailPresenterToInteractorProtocol {
   
    var presenter: GameDetailInteractorToPresenterProtocol?
    var service: APIServiceable
    var gameID: String
    
    init(gameID: String, service: APIServiceable) {
        self.gameID = gameID
        self.service = service
    }
    
    func load() {
//        presenter?.handleOutput(.showLoading(true))
        
        Task(priority: .background) {
            let result = await service.getGameLookup(gameID: gameID)
//            presenter?.handleOutput(.showLoading(false))
            
            switch result {
            case .success(let data):
                presenter?.handleOutput(.load(data: data))
            case .failure(let error):
                presenter?.handleOutput(.showError(error))
            }
        }
    }
}
