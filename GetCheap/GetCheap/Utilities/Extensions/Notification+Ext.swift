//
//  Notification+Ext.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation


extension Notification.Name {
    public static let networkReachabilityChanged = Notification.Name(rawValue: "NetworkReachabilityChanged")
}


extension Notification {
    static func networkReachabilityChanged(status: NetworkStatus) {
        NotificationCenter.default.post(name: .networkReachabilityChanged
                                        , object: nil
                                        , userInfo: [AppConstants.NETWORK_STATUS : status])
    }
}
