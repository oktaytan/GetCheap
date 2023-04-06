//
//  RequestError.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unAuthorized
    case unexpectedStatusCode
    case noConnection
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .noConnection:
            return "No internet connection"
        default:
            return "Unknown error"
        }
    }
}
