//
//  StoreDetailEntity.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

struct StoreDetailEntity {
    let banner: String
    let deals: [DealEntity]
    
    init(banner: String, dealList: [Deal]) {
        self.banner = banner
        self.deals = dealList.map({ DealEntity.init($0) })
    }
}
