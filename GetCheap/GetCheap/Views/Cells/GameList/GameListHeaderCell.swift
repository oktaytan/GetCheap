//
//  GameListHeaderCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

class GameListHeaderCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        messageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        messageLabel.textColor = .grayDark
    }
    
    func setData(_ message: String) {
        messageLabel.text = message
    }
}
