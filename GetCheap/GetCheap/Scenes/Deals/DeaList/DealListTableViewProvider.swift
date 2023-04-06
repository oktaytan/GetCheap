//
//  DealListTableViewProvider.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import UIKit

protocol DealListTableViewProvider {
    var stateClosure: ((ObservationType<DealListTableViewProviderImpl.UserInteractivity, Error>) -> ())? { get set }
    func setData(data: [DealListPresenterOutput.RowType]?)
    func tableViewReload()
    func setupTableView(tableView: UITableView)
}

final class DealListTableViewProviderImpl: NSObject, TableViewProvider, DealListTableViewProvider {
    
    typealias T = DealListPresenterOutput.RowType
    typealias I = IndexPath
    
    var dataList: [T]?
    var stateClosure: ((ObservationType<UserInteractivity, Error>) -> ())?
    
    private var tableView: UITableView?
    
    /// ViewModel' den view'e gelen datayı provider'a gönderir.
    /// - Parameter data: PokeListViewModelImpl.RowType
    func setData(data: [T]?) {
        self.dataList = data
        tableViewReload()
    }
    
    /// TableView'i reload eder.
    func tableViewReload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    /// TableView'in delegate ve datasource özelliklerini setler. Cell register işlemlerini gerçekleştirir.
    /// - Parameter tableView: UITableView
    func setupTableView(tableView: UITableView) {
        self.tableView = tableView
        let cells = [EmptyTableViewCell.self, DealListItemCell.self]
        self.tableView?.register(cellTypes: cells)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = .none
        self.tableView?.sectionHeaderHeight = 16.0
        self.tableView?.sectionFooterHeight = 32.0
        self.tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    }
}

extension DealListTableViewProviderImpl {
    /// Provider ile ViewController arasındaki iletişim sırasındaki event'leri tanımlar
    enum UserInteractivity {
        case storeLookup(storeBanner: String, storeID: String), dealLookup(_ dealID: String)
    }
}

// MARK: - Provider'ın üstlendiği delegate ve dataSource fonksiyonları
extension DealListTableViewProviderImpl: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = dataList?[indexPath.row] else { return UITableViewCell() }
        switch rowType {
        case .deal(let entity):
            let cell = tableView.dequeueReusableCell(with: DealListItemCell.self, for: indexPath)
            cell.setData(entity, delegate: self)
            return cell
        case .empty:
            let cell = tableView.dequeueReusableCell(with: EmptyTableViewCell.self, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowType = dataList?[indexPath.row] else { return .zero }
        switch rowType {
        case .deal: return UITableView.automaticDimension
        case .empty: return tableView.bounds.height
        }
    }
}


extension DealListTableViewProviderImpl: DealListItemCellDelegate {
    func userActivityEvent(with event: DealListItemCell.UserActivity) {
        switch event {
        case .seeAll(let storeBanner, let storeID):
            stateClosure?(.updateUI(data: .storeLookup(storeBanner: storeBanner, storeID: storeID)))
        case .goToDeal(let dealID):
            stateClosure?(.updateUI(data: .dealLookup(dealID)))
        }
    }
}
