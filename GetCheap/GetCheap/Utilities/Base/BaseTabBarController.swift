//
//  BaseTabBarController.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import UIKit
import SPIndicator

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarUI()
    }
    
    private func setTabBarUI() {
        tabBar.backgroundColor = .grayLight
    }
    
    func showToastMessage(title: String?, message: String?, preset: SPIndicatorIconPreset) {
        DispatchQueue.main.async {
            SPIndicator.present(title: title ?? "", message: message, preset: preset)
        }
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            UIAlertAction in
            print("OK Pressed")
        }
        
        alertController.addAction(okAction)
        
        guard let navigationController = selectedViewController as? UINavigationController,
              let activeController = navigationController.visibleViewController as? BaseViewController else {
            return
        }
        
        DispatchQueue.main.async {
            activeController.present(alertController, animated: true)
        }
    }
}
