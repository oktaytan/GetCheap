//
//  GameDetailHeadCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import UIKit

class GameDetailHeadCell: UITableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.cornerRadius = 6.0
        
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .blackSoft
    }
    
    func setData(banner: String, title: String) {
        bannerImageView.loadImage(urlString: banner, placeholder: "placeholder-landscape")
        nameLabel.text = title
    }
}
