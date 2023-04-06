//
//  APIService.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

protocol APIServiceable {
    func getDeals(storeID: String) async -> Result<[Deal], RequestError>
    func getDealLookup(dealID: String) async -> Result<DealLookup, RequestError>
    
    func getGames(title: String) async -> Result<[Game], RequestError>
    func getGameLookup(gameID: String) async -> Result<GameLookup, RequestError>
    
    func getStores() async -> Result<[Store], RequestError>
}

struct APIService: HTTPCLient, APIServiceable {
    func getDeals(storeID: String) async -> Result<[Deal], RequestError> {
        return await sendRequest(endpoint: APIEndpoint.dealList(storeID: storeID), model: [Deal].self)
    }
    
    func getDealLookup(dealID: String) async -> Result<DealLookup, RequestError> {
        return await sendRequest(endpoint: APIEndpoint.dealLookup(dealID: dealID), model: DealLookup.self)
    }
    
    func getGames(title: String) async -> Result<[Game], RequestError> {
        return await sendRequest(endpoint: APIEndpoint.gameList(title: title), model: [Game].self)
    }
    
    func getGameLookup(gameID: String) async -> Result<GameLookup, RequestError> {
        return await sendRequest(endpoint: APIEndpoint.gameLookup(gameID: gameID), model: GameLookup.self)
    }
    
    func getStores() async -> Result<[Store], RequestError> {
        return await sendRequest(endpoint: APIEndpoint.storeList, model: [Store].self)
    }
}
