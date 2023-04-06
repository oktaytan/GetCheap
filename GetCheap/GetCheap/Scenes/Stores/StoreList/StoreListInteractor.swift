//
//  StoreListInteractor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class StoreListInteractor: StoreListPresenterToInteractorProtocol {
    
    var presenter: StoreListInteractorToPresenterProtocol?
    var service: APIServiceable
    
    init(service: APIServiceable) {
        self.service = service
    }
    
    func load() {
        presenter?.handleOutput(.showLoading(true))
        
        Task(priority: .background) { [weak self] in
            let result = await self?.service.getStores()
            
            switch result {
            case .success(let stores):
                self?.presenter?.handleOutput(.showLoading(false))
                self?.presenter?.handleOutput(.data(stores))
            case .failure(let error):
                self?.presenter?.handleOutput(.showError(error))
            default:
                break
            }
        }
    }
}
