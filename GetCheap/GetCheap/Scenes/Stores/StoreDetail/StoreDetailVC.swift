//
//  StoreDetailVC.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

final class StoreDetailVC: BaseViewController, ListControllerBehaviorally {
    
    typealias Presenter = StoreDetailViewToPresenterProtocol
    typealias Provider = StoreDetailCollectionViewProvider
    
    var presenter: Presenter!
    var provider: Provider!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservationListener()
        setupListView()
        presenter.load()
    }
    
    func inject(presenter: Presenter, provider: Provider) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func addObservationListener() {
        provider.stateClosure = { [weak self] event in
            switch event {
            case .updateUI(let data):
                self?.collectionViewUserActivity(event: data)
            default:
                break
            }
        }
    }
    
    func setupListView() {
        provider.setupCollectionView(collectionView: self.collectionView)
    }
    
    private func setData(_ data: [StoreDetailPresenterOutput.ItemType]) {
        provider.setData(data: data)
    }
    
    private func setBanner(_ urlString: String) {
        DispatchQueue.main.async { [weak self] in
            let imageUrlString = "https://" + AppConstants.SERVICE_HOST + urlString
            self?.bannerImageView.loadImage(urlString: imageUrlString, placeholder: "placeholder-landscape")
        }
    }
    
}


extension StoreDetailVC {
    private func collectionViewUserActivity(event: StoreDetailCollectionViewProviderImpl.UserInteractivity?) {
        switch event {
        case .dealLookup(let dealID):
            presenter.goToDealDetail(dealID: dealID)
        default:
            break
        }
    }
}



extension StoreDetailVC: StoreDetailPresenterToViewProtocol {
    func handleOutput(_ output: StoreDetailPresenterOutput) {
        switch output {
        case .load(let banner, let deals):
            setBanner(banner)
            setData(deals)
        case .showLoading(let show):
            handleLoading(show)
        case .showError(let error):
            showToastMessage(title: nil, message: error.customMessage, preset: .error)
        }
    }
}
