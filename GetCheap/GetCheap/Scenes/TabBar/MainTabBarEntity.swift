//
//  MainTabBarEntity.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation
import UIKit.UIImage

enum TabItemType: String, CaseIterable {
    case deals, games, stores, settings
    
    var title: String {
        switch self {
        case .deals: return "Deals"
        case .games: return "Games"
        case .stores: return "Stores"
        case .settings: return "Settings"
        }
    }
    
    var vc: BaseViewController {
        switch self {
        case .deals:
            return DealListRouter.createModule()
        case .games:
            return GameListRouter.createModule()
        case .stores:
            return StoreListRouter.createModule()
        case .settings:
            return SettingsRouter.createModule()
        }
    }
    
    var icon: UIImage {
        return UIImage(named: "\(rawValue)-icon")!
    }
    
    var selectedIcon: UIImage {
        return UIImage(named: "\(rawValue)-icon-selected")!
    }
}
