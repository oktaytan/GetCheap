//
//  StoreListEntity.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

struct StoreListEntity {
    let id: String
    let name: String
    let logo: String
    let banner: String
    let isActive: Bool
    
    init(store: Store) {
        self.id = store.storeID
        self.name = store.storeName
        self.logo = store.images.logo
        self.banner = store.images.banner
        self.isActive = store.isActive == 1
    }
}
