//
//  MainTabBarInteractor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

final class MainTabBarInteractor: TabBarPresenterToInteractorProtocol {
    var presenter: TabBarInteractorToPresenterProtocol?
    
    var monitor: NetworkMonitorProtocol
    
    init(monitor: NetworkMonitorProtocol) {
        self.monitor = monitor
    }
    
    func load() {
        monitor.start()
        NotificationCenter.default.addObserver(self, selector: #selector(networkReachabilityChanged(_:)), name: .networkReachabilityChanged, object: nil)
    }
    
    func checkConnection() {
        presenter?.handleOutput(.networkReachability(monitor.status))
    }
    
    deinit {
        monitor.stop()
        NotificationCenter.default.removeObserver(self, name: .networkReachabilityChanged, object: nil)
    }
}

extension MainTabBarInteractor {
    @objc func networkReachabilityChanged(_ notification: Notification) {
        guard let status = notification.userInfo?[AppConstants.NETWORK_STATUS] as? NetworkStatus  else { return }
        presenter?.handleOutput(.networkReachability(status))
    }
}
