//
//  GameListItemCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

class GameListItemCell: UITableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var salePriceLabel: BadgeLabel!
    @IBOutlet weak var priceTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.cornerRadius = 6.0
        
        nameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        nameLabel.textColor = .blackSoft
        
        salePriceLabel.configure(color: .blueSoft, font: .systemFont(ofSize: 14, weight: .bold), strike: false)
        
        priceTypeLabel.font = .systemFont(ofSize: 10, weight: .regular)
        priceTypeLabel.textColor = .grayDark
        priceTypeLabel.text = "Cheapest"
    }
    
    func setData(_ data: GameEntity) {
        bannerImageView.loadImage(urlString: data.thumbnail, placeholder: "placeholder-landscape")
        nameLabel.text = data.name
        salePriceLabel.text = data.price
    }
}
