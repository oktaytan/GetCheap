//
//  Deal.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation


// MARK: - Deal
struct Deal: Codable {
    let title, dealID, storeID, gameID: String
    let salePrice, normalPrice: String
    let dealRating: String
    let thumb: String
}


// MARK: - DealLookup
struct DealLookup: Codable {
    let gameInfo: GameInfo
    let cheaperStores: [CheaperStore]
    let cheapestPrice: CheapestPrice
}

// MARK: - CheaperStore
struct CheaperStore: Codable {
    let dealID, storeID, salePrice, retailPrice: String
}

// MARK: - CheapestPrice
struct CheapestPrice: Codable {
    let price: String
    let date: Int
}

// MARK: - GameInfo
struct GameInfo: Codable {
    let storeID, gameID, name, steamAppID: String
    let salePrice, retailPrice, steamRatingText, steamRatingPercent: String
    let steamRatingCount, metacriticScore, metacriticLink: String
    let releaseDate: Int
    let publisher, steamworks: String
    let thumb: String
}
