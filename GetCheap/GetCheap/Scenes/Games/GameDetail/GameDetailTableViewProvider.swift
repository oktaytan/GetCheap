//
//  GameDetailTableViewProvider.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import UIKit

protocol GameDetailTableViewProvider {
    var stateClosure: ((ObservationType<GameDetailTableViewProviderImpl.UserInteractivity, Error>) -> ())? { get set }
    func setData(data: [GameDetailPresenterOutput.SectionType]?)
    func tableViewReload()
    func setupTableView(tableView: UITableView)
}

final class GameDetailTableViewProviderImpl: NSObject, TableViewProvider, GameDetailTableViewProvider {
    
    typealias T = GameDetailPresenterOutput.SectionType
    typealias I = IndexPath
    
    var dataList: [T]?
    var stateClosure: ((ObservationType<UserInteractivity, Error>) -> ())?
    
    private var tableView: UITableView?
    
    /// ViewModel' den view'e gelen datayı provider'a gönderir.
    /// - Parameter data: GameDetailPresenterOutput.SectionType
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
        let cells = [GameDetailHeadCell.self, GameDetailCell.self, GameDetailDealCell.self]
        self.tableView?.register(cellTypes: cells)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = .none
        self.tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    }
}

extension GameDetailTableViewProviderImpl {
    /// Provider ile ViewController arasındaki iletişim sırasındaki event'leri tanımlar
    enum UserInteractivity {
        case goToDeal(dealID: String)
    }
}

// MARK: - Provider'ın üstlendiği delegate ve dataSource fonksiyonları
extension GameDetailTableViewProviderImpl: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = dataList?[section] else { return 0 }
        switch sectionType {
        case .head, .detail: return 1
        case .deals(let rows): return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = dataList?[indexPath.section] else { return UITableViewCell() }
        switch sectionType {
        case .head(let banner, let title):
            let cell = tableView.dequeueReusableCell(with: GameDetailHeadCell.self, for: indexPath)
            cell.setData(banner: banner, title: title)
            return cell
        case .detail(let releaseDate, let salePrice):
            let cell = tableView.dequeueReusableCell(with: GameDetailCell.self, for: indexPath)
            cell.setData(releaseDate: releaseDate, salePrice: salePrice)
            return cell
        case .deals(let rows):
            return getCellForRow(tableView, rows: rows, at: indexPath)
        }
    }
    
    private func getCellForRow(_ tableView: UITableView, rows: [GameDetailPresenterOutput.RowType], at indexPath: IndexPath) -> UITableViewCell {
        let rowType = rows[indexPath.row]
        switch rowType {
        case .deal(let entity):
            let cell = tableView.dequeueReusableCell(with: GameDetailDealCell.self, for: indexPath)
            cell.setData(entity)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = dataList?[section] else { return nil }
        switch sectionType {
        case .deals:
            return "Deals"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = dataList?[indexPath.section] else { return }
        switch sectionType {
        case .deals(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .deal(let entity):
                stateClosure?(.updateUI(data: .goToDeal(dealID: entity.dealID)))
            }
        default:
            break
        }
    }
}
