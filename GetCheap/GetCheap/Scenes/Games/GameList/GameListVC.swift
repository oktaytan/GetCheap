//
//  GameListVC.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import UIKit

final class GameListVC: BaseViewController, ListControllerBehaviorally {
    
    typealias Presenter = GameListViewToPresenterProtocol
    typealias Provider = GameListTableViewProvider
    
    var presenter: Presenter!
    var provider: Provider!
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservationListener()
        setupListView()
        presenter.load()
    }
    
    override func setupView() {
        super.setupView()
        setupNavBar(title: "Games")
        setSearchController()
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .blueSoft
        navigationItem.searchController = searchController
        definesPresentationContext = false
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
    
    private func setData(_ data: [GameListPresenterOutput.SectionType]) {
        provider.setData(data: data)
    }
}


extension GameListVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      guard let searchText = searchController.searchBar.text, searchText != "" else { return }
      presenter.search(title: searchText)
  }
}

extension GameListVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.popular()
    }
}


extension GameListVC {
    private func tableViewUserActivity(event: GameListTableViewProviderImpl.UserInteractivity?) {
        switch event {
        case .gameLookup(let gameID):
            presenter.goToGameDetail(gameID: gameID)
        default:
            break
        }
    }
}


extension GameListVC: GameListPresenterToViewProtocol {
    func handleOutput(_ output: GameListPresenterOutput) {
        switch output {
        case .load(let data):
            self.setData(data)
        case .showLoading(let show):
            handleLoading(show)
        case .showError(let error):
            showToastMessage(title: nil, message: error.customMessage, preset: .error)
        }
    }
}
