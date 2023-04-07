//
//  GameEntity.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

struct GameEntity {
    let id: String
    let name: String
    let price: String
    let thumbnail: String
    
    init(_ data: Game) {
        self.id = data.gameID
        self.name = data.external
        self.price = "$" + data.cheapest
        self.thumbnail = data.thumb
    }
    
    init(_ data: MultipleGameItem) {
        self.id = data.info.gameID
        self.name = data.info.title
        self.price = "$" + data.cheapestPriceEver.price
        self.thumbnail = data.info.thumb
    }
    
    static func setData(_ data: Any) -> GameEntity? {
        if let game = data as? MultipleGameItem {
            return self.init(game)
        } else if let game = data as? Game {
            return self.init(game)
        } else {
            return nil
        }
    }
}
