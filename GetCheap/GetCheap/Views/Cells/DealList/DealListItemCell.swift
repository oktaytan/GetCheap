//
//  DealListItemCell.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import UIKit

protocol DealListItemCellDelegate: AnyObject {
    func userActivityEvent(with event: DealListItemCell.UserActivity)
}

extension DealListItemCellDelegate {
    func userActivityEvent(with event: DealListItemCell.UserActivity) {}
}

class DealListItemCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: DealListItemCellDelegate?
    var entity: DealListEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        thumbImageView.contentMode = .scaleAspectFit
        
        storeNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        storeNameLabel.textColor = .blackSoft
        
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setTitleColor(.grayDark, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 14
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: DealListDetailCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
    }
    
    func setData(_ entity: DealListEntity, delegate: DealListItemCellDelegate?) {
        self.entity = entity
        self.delegate = delegate
        
        let imageUrlString = "https://" + AppConstants.SERVICE_HOST + entity.storeLogo
        thumbImageView.loadImage(urlString: imageUrlString, placeholder: "placeholder")
        storeNameLabel.text = entity.storeName
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        guard let entity = self.entity else { return }
        delegate?.userActivityEvent(with: .seeAll(storeBanner: entity.storeBanner,storeID: entity.storeID))
    }
}


extension DealListItemCell {
    enum UserActivity {
        case seeAll(storeBanner: String, storeID: String), goToDeal(dealID: String)
    }
}


extension DealListItemCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let deal = entity?.deals[indexPath.item] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(cellType: DealListDetailCell.self, indexPath: indexPath)
        cell.setData(deal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let deal = entity?.deals[indexPath.item] else { return }
        delegate?.userActivityEvent(with: .goToDeal(dealID: deal.id))
    }
}
