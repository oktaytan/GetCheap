//
//  StoreDetailInteractor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

final class StoreDetailInteractor: StoreDetailPresenterToInteractorProtocol {
    
    var presenter: StoreDetailInteractorToPresenterProtocol?
    var service: APIServiceable
    var storeID: String
    var storeBanner: String
    
    init(storeID: String, storeBanner: String, service: APIServiceable) {
        self.storeID = storeID
        self.storeBanner = storeBanner
        self.service = service
    }
    
    func load() {
        Task(priority: .background) { [weak self] in
            guard let self else { return }
            let result = await service.getDeals(storeID: self.storeID)
            
            switch result {
            case .success(let data):
                self.presenter?.handleOutput(.data(banner: self.storeBanner, deals: data))
            case .failure(let error):
                self.presenter?.handleOutput(.showError(error))
            }
        }
    }
}
