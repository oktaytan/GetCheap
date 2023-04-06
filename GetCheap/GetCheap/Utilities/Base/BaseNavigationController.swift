//
//  BaseNavigationController.swift
//  Kartoon
//
//  Created by Oktay Tanrıkulu on 31.03.2023.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
    }
    
    private func setNavBar() {
        self.navigationBar.titleTextAttributes = [ .foregroundColor : UIColor.blueSoft,
                                                   .font : UIFont.systemFont(ofSize: 14, weight: .semibold)]
        self.navigationBar.backgroundColor = .grayLight
        self.navigationBar.tintColor = .blueSoft
    }
    
}
