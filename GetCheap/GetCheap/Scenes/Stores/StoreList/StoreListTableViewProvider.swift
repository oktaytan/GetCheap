//
//  StoreListTableViewProvider.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

protocol StoreListTableViewProvider {
    var stateClosure: ((ObservationType<StoreListTableViewProviderImpl.UserInteractivity, Error>) -> ())? { get set }
    func setData(data: [StoreListPresenterOutput.RowType]?)
    func tableViewReload()
    func setupTableView(tableView: UITableView)
}

final class StoreListTableViewProviderImpl: NSObject, TableViewProvider, StoreListTableViewProvider {
    
    typealias T = StoreListPresenterOutput.RowType
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
        let cells = [EmptyTableViewCell.self, StoreListItemCell.self]
        self.tableView?.register(cellTypes: cells)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = .none
        self.tableView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension StoreListTableViewProviderImpl {
    /// Provider ile ViewController arasındaki iletişim sırasındaki event'leri tanımlar
    enum UserInteractivity {
        case storeLookup(storeBanner: String, storeID: String)
    }
}

// MARK: - Provider'ın üstlendiği delegate ve dataSource fonksiyonları
extension StoreListTableViewProviderImpl: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = dataList?[indexPath.row] else { return UITableViewCell() }
        switch rowType {
        case .store(let entity):
            let cell = tableView.dequeueReusableCell(with: StoreListItemCell.self, for: indexPath)
            cell.setData(entity)
            return cell
        case .empty:
            let cell = tableView.dequeueReusableCell(with: EmptyTableViewCell.self, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowType = dataList?[indexPath.row] else { return .zero }
        switch rowType {
        case .store: return UITableView.automaticDimension
        case .empty: return tableView.bounds.height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowType = dataList?[indexPath.row] else { return }
        switch rowType {
        case .store(let entity):
            stateClosure?(.updateUI(data: .storeLookup(storeBanner: entity.banner, storeID: entity.id)))
        default:
            break
        }
    }
}
