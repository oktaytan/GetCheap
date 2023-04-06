//
//  StoreListItemCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

class StoreListItemCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var storeLogoImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var activeDotView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.borderWidth = 1.0
        containerView.cornerRadius = 10.0
        
        storeLogoImageView.contentMode = .scaleAspectFit
        
        storeNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        storeNameLabel.textColor = .blackSoft
        
        activeLabel.font = .systemFont(ofSize: 12, weight: .medium)
        activeLabel.textColor = .grayDark
        
        activeDotView.fullRound()
    }
    
    func setData(_ data: StoreListEntity) {
        DispatchQueue.main.async { [weak self] in
            let imageUrlString = "https://" + AppConstants.SERVICE_HOST + data.logo
            self?.storeLogoImageView.loadImage(urlString: imageUrlString, placeholder: "placeholder")
            self?.storeLogoImageView.alpha = data.isActive ? 1.0 : 0.5
            
            self?.storeNameLabel.text = data.name
            self?.storeNameLabel.textColor = data.isActive ? .blackSoft : .grayDark
            
            self?.activeLabel.text = data.isActive ? "Active" : "Deactive"
            
            let color: UIColor = data.isActive ? .blueSoft : .yellowSoft
            self?.containerView.layer.borderColor = color.cgColor
            self?.activeLabel.textColor = color
            self?.activeDotView.backgroundColor = color
        }
    }
}
