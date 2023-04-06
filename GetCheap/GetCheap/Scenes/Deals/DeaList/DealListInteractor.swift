//
//  DealListInteractor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import Foundation

final class DealListInteractor: DealListPresenterToInteractorProtocol {
    
    var presenter: DealListInteractorToPresenterProtocol?
    var service: APIServiceable
    var deals = [Store: [Deal]]()
    
    init(service: APIServiceable) {
        self.service = service
    }
    
    func load() {
        presenter?.handleOutput(.showLoading(true))
        
        Task(priority: .background) { [weak self] in
            let result = await self?.service.getStores()
            
            switch result {
            case .success(let stores):
                let activeStores = stores.filter({ $0.isActive == 1 })
                
                for store in activeStores {
                    await self?.getDeals(for: store)
                }
                
                self?.presenter?.handleOutput(.showLoading(false))
            case .failure(let error):
                self?.presenter?.handleOutput(.showError(error))
            default:
                break
            }
        }
    }
    
    private func getDeals(for store: Store) async {
        let result = await service.getDeals(storeID: store.storeID)
        
        switch result {
        case .success(let data):
            deals[store] = data
            presenter?.handleOutput(.data(self.deals))
        case .failure(let error):
            presenter?.handleOutput(.showError(error))
        }
    }
}
