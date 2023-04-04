//
//  MainTabBarInteractor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

final class MainTabBarInteractor: TabBarPresenterToInteractorProtocol {
    var presenter: TabBarInteractorToPresenterProtocol?
    
    var reachability: Reachability
    
    init(reachability: Reachability) {
        self.reachability = reachability
    }
    
    func load() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}

extension MainTabBarInteractor {
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        checkReachability(reachability)
    }
    
    func checkConnection() {
        checkReachability(self.reachability)
    }
    
    private func checkReachability(_ reachability: Reachability) {
        switch reachability.connection {
        case .wifi, .cellular:
            break
        case .unavailable:
            presenter?.handleOutput(.networkNotReachable)
        }
    }
}
