//
//  GameDetailCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import UIKit

class GameDetailCell: UITableViewCell {

    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: BadgeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        dateTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateTitleLabel.textColor = .grayDark
        dateTitleLabel.text = "Date"
        
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dateLabel.textColor = .blackSoft
        
        priceTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        priceTitleLabel.textColor = .grayDark
        priceTitleLabel.text = "Cheapest Price Ever"
        
        priceLabel.configure(color: .blueSoft)
    }
    
    func setData(releaseDate: String, salePrice: String) {
        dateLabel.text = releaseDate
        priceLabel.text = salePrice
    }
}
