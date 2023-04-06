//
//  DealListDetailCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import UIKit

class DealListDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var normalPrice: UILabel!
    @IBOutlet weak var salePrice: BadgeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .grayLight
        contentView.cornerRadius = 10
        
        thumbImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        nameLabel.textColor = .blackSoft
        
        ratingLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        ratingLabel.textColor = .blackSoft
        
        normalPrice.font = .systemFont(ofSize: 13, weight: .regular)
        normalPrice.textColor = .grayDark
        salePrice.configure(color: .blueSoft)
    }
    
    func setData(_ data: DealEntity) {
        thumbImageView.loadImage(urlString: data.thumbnail, placeholder: "placeholder")
        nameLabel.text = data.name
        ratingLabel.text = data.rating
        normalPrice.attributedText = data.normalPrice.strike()
        salePrice.text = data.salePrice
    }

}
