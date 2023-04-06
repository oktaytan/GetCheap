//
//  DealListEntity.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import Foundation


struct DealEntity {
    let id: String
    let thumbnail: String
    let name: String
    let rating: String
    let normalPrice: String
    let salePrice: String
    
    init(_ deal: Deal) {
        self.id = deal.dealID
        self.thumbnail = deal.thumb
        self.name = deal.title
        self.rating = deal.dealRating
        self.normalPrice = "$" + deal.normalPrice
        self.salePrice = "$" + deal.salePrice
    }
}

struct DealListEntity {
    let storeID: String
    let storeName: String
    let storeLogo: String
    let storeBanner: String
    let deals: [DealEntity]
    
    init(store: Store, dealList: [Deal]) {
        self.storeID = store.storeID
        self.storeName = store.storeName
        self.storeLogo = store.images.logo
        self.storeBanner = store.images.banner
        self.deals = dealList.map({ DealEntity.init($0) })
    }
}


