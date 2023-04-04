//
//  NetworkMonitor.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation
import Network

enum NetworkStatus: String {
    case hasConnection = "Network the reachable"
    case noConnection = "Network not reachable.\n Try again!"
}

protocol NetworkMonitorProtocol: AnyObject {
    var status: NetworkStatus { get set }
    
    func start()
    func stop()
}

final class NetworkMonitor: NetworkMonitorProtocol {
    
    static let shared = NetworkMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue(label: "com.oktaytan.getCheap")
    var status: NetworkStatus = .hasConnection
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    func start() {
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            switch path.status {
            case .satisfied:
                self.status = .hasConnection
                Notification.networkReachabilityChanged(status: .hasConnection)
            case .unsatisfied, .requiresConnection:
                self.status = .noConnection
                Notification.networkReachabilityChanged(status: .noConnection)
            default:
                break
            }
        }
    }
    
    func stop() {
        monitor.cancel()
    }
    
}
