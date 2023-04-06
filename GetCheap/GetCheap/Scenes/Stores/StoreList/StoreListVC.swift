//
//  StoreListVC.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import UIKit

final class StoreListVC: BaseViewController, ListControllerBehaviorally {
    
    typealias Presenter = StoreListViewToPresenterProtocol
    typealias Provider = StoreListTableViewProvider
    
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
        setupNavBar(title: "Stores")
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
    
    private func setData(_ data: [StoreListPresenterOutput.RowType]) {
        provider.setData(data: data)
    }
}


extension StoreListVC {
    private func tableViewUserActivity(event: StoreListTableViewProviderImpl.UserInteractivity?) {
        switch event {
        case .storeLookup(let storeBanner, let storeID):
            presenter.goToStore(storeBanner: storeBanner, storeID: storeID)
        default:
            break
        }
    }
}


extension StoreListVC: StoreListPresenterToViewProtocol {
    func handleOutput(_ output: StoreListPresenterOutput) {
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
