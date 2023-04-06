//
//  Game.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

// MARK: - Game
struct Game: Codable {
    let gameID, steamAppID, cheapest, cheapestDealID: String
    let external, internalName: String
    let thumb: String
}

// MARK: - GameLookup
struct GameLookup: Codable {
    let info: Info
    let cheapestPriceEver: CheapestPriceEver
    let deals: [GameForDeal]
}

// MARK: - CheapestPriceEver
struct CheapestPriceEver: Codable {
    let price: String
    let date: Int
}

// MARK: - Deal
struct GameForDeal: Codable {
    let storeID, dealID, price, retailPrice: String
    let savings: String
}

// MARK: - Info
struct Info: Codable {
    let title: String
    let steamAppID: String?
    let thumb: String
}
