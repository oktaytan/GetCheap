//
//  GameDetailVC.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import UIKit

final class GameDetailVC: BaseViewController, ListControllerBehaviorally {
    
    typealias Presenter = GameDetailViewToPresenterProtocol
    typealias Provider = GameDetailTableViewProvider
    
    var presenter: Presenter!
    var provider: Provider!
    
    @IBOutlet weak var tableView: UITableView!
    
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
                self?.tableViewUserActivity(event: data)
            default:
                break
            }
        }
    }
    
    func setupListView() {
        provider.setupTableView(tableView: self.tableView)
    }
    
    private func setData(_ data: [GameDetailPresenterOutput.SectionType]) {
        provider.setData(data: data)
    }
}


extension GameDetailVC {
    private func tableViewUserActivity(event: GameDetailTableViewProviderImpl.UserInteractivity?) {
        switch event {
        case .goToDeal(let dealID):
            presenter.goToGameDeal(dealID: dealID)
        default:
            break
        }
    }
}


extension GameDetailVC: GameDetailPresenterToViewProtocol {
    func handleOutput(_ output: GameDetailPresenterOutput) {
        switch output {
        case .load(let data):
            setData(data)
        case .showLoading(let show):
            handleLoading(show)
        case .showError(let error):
            showToastMessage(title: nil, message: error.customMessage, preset: .error)
        }
    }
}
