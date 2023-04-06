//
//  DealListVC.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import UIKit

final class DealListVC: BaseViewController, ListControllerBehaviorally {
    
    typealias Presenter = DealListViewToPresenterProtocol
    typealias Provider = DealListTableViewProvider
    
    var presenter: Presenter!
    var provider: Provider!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservationListener()
        setupListView()
        presenter.load()
    }
    
    override func setupView() {
        super.setupView()
        setupNavBar(title: "Deals", rightIcon: "filter-icon", rightItemAction: #selector(filter))
    }
    
    func inject(presenter: Presenter, provider: Provider) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func addObservationListener() {
        provider.stateClosure = { [weak self] event in
            switch event {
            case .updateUI(let data):
                self?.tableViewUserActivity(event: data)
            default:
                break
            }
        }
    }
    
    func setupListView() {
        provider.setupTableView(tableView: self.tableView)
    }
    
    private func setData(_ data: [DealListPresenterOutput.RowType]) {
        provider.setData(data: data)
    }
    
    @objc func filter() {
        print("filter")
    }
}


extension DealListVC {
    private func tableViewUserActivity(event: DealListTableViewProviderImpl.UserInteractivity?) {
        switch event {
        case .storeLookup(let storeBanner, let storeID):
            presenter.goToStore(storeBanner: storeBanner, storeID: storeID)
        case .dealLookup(let dealID):
            presenter.goToDealDetail(dealID: dealID)
        default:
            break
        }
    }
}


extension DealListVC: DealListPresenterToViewProtocol {
    func handleOutput(_ output: DealListPresenterOutput) {
        switch output {
        case .load(let data):
            setData(data)
        case .showLoading(let show):
            self.handleLoading(show)
        case .showError(let error):
            showToastMessage(title: nil, message: error.customMessage, preset: .error)
        }
    }
}
