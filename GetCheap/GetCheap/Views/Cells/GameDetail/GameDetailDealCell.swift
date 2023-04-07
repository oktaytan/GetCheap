//
//  GameDetailDealCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import UIKit

class GameDetailDealCell: UITableViewCell {

    @IBOutlet weak var savingsTitleLabel: UILabel!
    @IBOutlet weak var savingsLabel: BadgeLabel!
    @IBOutlet weak var retailPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: BadgeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        savingsTitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        savingsTitleLabel.textColor = .grayDark
        savingsTitleLabel.text = "Savings"
        
        savingsLabel.configure(color: .systemGreen, font: .systemFont(ofSize: 12, weight: .bold))
        
        retailPriceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        retailPriceLabel.textColor = .grayDark
        
        salePriceLabel.configure(color: .blueSoft)
    }
    
    func setData(_ data: GameDealEntity) {
        savingsLabel.text = data.savings
        retailPriceLabel.attributedText = data.retailPrice.strike()
        salePriceLabel.text = data.salePrice
    }
}
