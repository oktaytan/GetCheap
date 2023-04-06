//
//  BadgeLabel.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import UIKit

final class BadgeLabel: UILabel {
    
    var color: UIColor = .blueSoft
    var strike: Bool = false
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = self.color.withAlphaComponent(0.2)
        view.cornerRadius = 4
        return view
    }()
    
    func configure(color: UIColor,
                   font: UIFont = .systemFont(ofSize: 14, weight: .bold),
                   strike: Bool = false) {
        self.color = color
        self.font = font
        self.strike = strike
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textColor = self.color
        
        if self.strike {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self.text ?? "")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            self.attributedText = attributeString
        }
        
        self.addSubview(bgView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: -4, paddingLeft: -6, paddingBottom: -4, paddingRight: -6)
    }
    
}
