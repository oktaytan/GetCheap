//
//  APIEndpoint.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation


enum APIEndpoint {
    case dealList(storeID: String)
    case dealLookup(dealID: String)
    case gameList(title: String)
    case gameLookup(gameID: String)
    case multipleGameLookup(gameIDs: String)
    case storeList
}

extension APIEndpoint: Endpoint {
    var version: String {
        return "/api/1.0"
    }
    
    var path: String {
        switch self {
        case .dealList, .dealLookup: return version + "/deals"
        case .gameList, .gameLookup, .multipleGameLookup: return version + "/games"
        case .storeList: return version + "/stores"
        }
    }
    
    var queries: [String : Any]? {
        switch self {
        case .dealList(let storeID):
            return ["storeID": storeID]
        case .dealLookup(let dealID):
            return ["id": dealID]
        case .gameList(let title):
            return ["title": title]
        case .gameLookup(let gameID):
            return ["id": gameID]
        case .multipleGameLookup(let gameIDs):
            return ["ids": gameIDs, "format": "array"]
        case .storeList:
            return nil
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .dealList, .dealLookup, .gameList, .gameLookup, .multipleGameLookup, .storeList: return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .dealList, .dealLookup, .gameList, .gameLookup, .multipleGameLookup, .storeList: return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .dealList, .dealLookup, .gameList, .gameLookup, .multipleGameLookup, .storeList: return nil
        }
    }
}
