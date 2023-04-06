//
//  NSAtttibutedText+Ext.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import Foundation

extension String {
    
    func strike() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
    
}
