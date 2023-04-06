//
//  Store.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

// MARK: - Store
struct Store: Codable, Hashable {
    let storeID, storeName: String
    let isActive: Int
    let images: Images
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(storeID)
    }
    
    static func == (lhs: Store, rhs: Store) -> Bool {
        return lhs.storeID == rhs.storeID
    }
}

// MARK: - Images
struct Images: Codable {
    let banner, logo, icon: String
}
