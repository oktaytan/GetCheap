//
//  Endpoint.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queries: [String: Any]? { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}


extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return AppConstants.SERVICE_HOST
    }
}
