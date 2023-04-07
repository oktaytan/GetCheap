//
//  UIApplication+Ext.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

extension UIApplication {
    
    var statusBarUIView: UIView? {
        
        if #available(iOS 13.0, *) {
            let tag = 3848245
            
            let keyWindow = UIApplication.shared.connectedScenes
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999
                
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
            
        } else {
            
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
    
    func goToDeal(dealID: String) {
        guard let url = URL(string: "https://\(AppConstants.SERVICE_HOST)/redirect?dealID=\(dealID)") else { return }
        self.open(url)
    }
}
