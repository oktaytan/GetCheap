//
//  StoreDetailCollectionViewProvider.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

protocol StoreDetailCollectionViewProvider {
    var stateClosure: ((ObservationType<StoreDetailCollectionViewProviderImpl.UserInteractivity, Error>) -> ())? { get set }
    func setData(data: [StoreDetailPresenterOutput.ItemType]?)
    func collectionViewReload()
    func setupCollectionView(collectionView: UICollectionView)
}

final class StoreDetailCollectionViewProviderImpl: NSObject, CollectionViewProvider, StoreDetailCollectionViewProvider {
    
    typealias T = StoreDetailPresenterOutput.ItemType
    typealias I = IndexPath
    
    var dataList: [T]?
    var stateClosure: ((ObservationType<UserInteractivity, Error>) -> ())?
    
    private var collectionView: UICollectionView?
    
    /// ViewModel' den view'e gelen datayı provider'a gönderir.
    /// - Parameter data: StoreDetailPresenterOutput.ItemType
    func setData(data: [T]?) {
        self.dataList = data
        collectionViewReload()
    }
    
    /// TableView'i reload eder.
    func collectionViewReload() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    /// CollectionView'in delegate ve datasource özelliklerini setler. Cell register işlemlerini gerçekleştirir.
    /// - Parameter tableView: UITableView
    func setupCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
        
        let cells = [StoreDetailEmptyCell.self, DealListDetailCell.self]
        self.collectionView?.register(cellTypes: cells)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

extension StoreDetailCollectionViewProviderImpl {
    /// Provider ile ViewController arasındaki iletişim sırasındaki event'leri tanımlar
    enum UserInteractivity {
        case dealLookup(_ dealID: String)
    }
}

// MARK: - Provider'ın üstlendiği delegate ve dataSource fonksiyonları
extension StoreDetailCollectionViewProviderImpl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemType = self.dataList?[indexPath.item] else { return UICollectionViewCell() }
        switch itemType {
        case .deals(let data):
            let cell = collectionView.dequeueReusableCell(cellType: DealListDetailCell.self, indexPath: indexPath)
            cell.setData(data)
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(cellType: StoreDetailEmptyCell.self, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let itemType = self.dataList?[indexPath.item] else { return .zero }
        switch itemType {
        case .deals: return CGSize(width: (collectionView.bounds.width - 60) / 2, height: 174)
        case .empty: return collectionView.bounds.size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemType = self.dataList?[indexPath.item] else { return }
        switch itemType {
        case .deals(let data):
            stateClosure?(.updateUI(data: .dealLookup(data.id)))
        default:
            break
        }
    }
}
