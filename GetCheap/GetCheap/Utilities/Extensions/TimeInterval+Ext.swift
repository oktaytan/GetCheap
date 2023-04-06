//
//  TimeInterval+Ext.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

extension TimeInterval {
    
    func getDate() -> String {
        let dateString = Date(timeIntervalSince1970: self).description(with: .current)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: dateString)?.description ?? ""
    }
}
