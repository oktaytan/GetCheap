//
//  GameDetailEntity.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import Foundation

struct GameDetailEntity {
    let name: String
    let thumbnail: String
    let date: String
    let price: String
    let deals: [GameDealEntity]
    
    init(_ data: GameLookup) {
        self.name = data.info.title
        self.thumbnail = data.info.thumb
        self.date = TimeInterval(data.cheapestPriceEver.date).getDate()
        self.price = "$" + data.cheapestPriceEver.price
        self.deals = data.deals.map(GameDealEntity.init)
    }
}

struct GameDealEntity {
    let dealID: String
    let storeID: String
    let salePrice: String
    let retailPrice: String
    let savings: String
    
    init(_ data: GameForDeal) {
        self.dealID = data.dealID
        self.storeID = data.storeID
        self.salePrice = "$" + data.price
        self.retailPrice = "$" + data.retailPrice
        self.savings = "% \(Int(Double(data.savings) ?? 0.0))"
    }
}
