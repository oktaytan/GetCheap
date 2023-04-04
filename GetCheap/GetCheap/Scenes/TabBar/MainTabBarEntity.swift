//
//  MainTabBarEntity.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation
import UIKit.UIImage

enum TabItemType: String, CaseIterable {
    case deal, game, store, setting
    
    var title: String {
        switch self {
        case .deal: return "Deals"
        case .game: return "Games"
        case .store: return "Store"
        case .setting: return "Setting"
        }
    }
    
    var vc: BaseViewController {
        switch self {
        case .deal:
            return DealVC(nibName: DealVC.className, bundle: nil)
        case .game:
            return GameVC(nibName: GameVC.className, bundle: nil)
        case .store:
            return StoreVC(nibName: StoreVC.className, bundle: nil)
        case .setting:
            return SettingVC(nibName: SettingVC.className, bundle: nil)
        }
    }
    
    var icon: UIImage {
        return UIImage(named: "\(rawValue)-icon")!
    }
    
    var selectedIcon: UIImage {
        return UIImage(named: "\(rawValue)-icon-selected")!
    }
}
