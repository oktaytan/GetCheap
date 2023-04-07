//
//  GameListInteractor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class GameListInteractor: GameListPresenterToInteractorProtocol {
    
    var presenter: GameListInteractorToPresenterProtocol?
    var service: APIServiceable
    private var pendingRequestWorkItem: DispatchWorkItem?
    private var title: String = ""
    
    init(service: APIServiceable) {
        self.service = service
    }
    
    func popular(gameIDs: [String]) {
        presenter?.handleOutput(.showLoading(true))
        
        Task(priority: .background) {
            let result = await service.getMultipleGameLookup(gameIDs: gameIDs)
            presenter?.handleOutput(.showLoading(false))
            
            switch result {
            case .success(let data):
                presenter?.handleOutput(.popular(data: data))
            case .failure(let error):
                presenter?.handleOutput(.showError(error))
            }
        }
    }
    
    func search(title: String) {
        self.title = title
        cancel()
        setWorkItem()
    }
    
    private func setWorkItem() {
        let requestWorkItem = DispatchWorkItem(qos: .background) { [weak self] in
            self?.fetchSearchItem()
        }
        
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: requestWorkItem)
    }
    
    private func cancel() {
        pendingRequestWorkItem?.cancel()
    }
    
    private func fetchSearchItem() {
        self.presenter?.handleOutput(.showLoading(true))
        
        Task(priority: .background) {
            let result = await self.service.getGames(title: self.title)
            self.presenter?.handleOutput(.showLoading(false))
            
            switch result {
            case .success(let data):
                self.presenter?.handleOutput(.search(data: data))
            case .failure(let error):
                self.presenter?.handleOutput(.showError(error))
            }
        }
    }
}
