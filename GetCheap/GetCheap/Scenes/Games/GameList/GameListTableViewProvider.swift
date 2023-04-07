//
//  GameListTableViewProvider.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import UIKit

protocol GameListTableViewProvider {
    var stateClosure: ((ObservationType<GameListTableViewProviderImpl.UserInteractivity, Error>) -> ())? { get set }
    func setData(data: [GameListPresenterOutput.SectionType]?)
    func tableViewReload()
    func setupTableView(tableView: UITableView)
}

final class GameListTableViewProviderImpl: NSObject, TableViewProvider, GameListTableViewProvider {
    
    typealias T = GameListPresenterOutput.SectionType
    typealias I = IndexPath
    
    var dataList: [T]?
    var stateClosure: ((ObservationType<UserInteractivity, Error>) -> ())?
    
    private var tableView: UITableView?
    
    /// ViewModel' den view'e gelen datayı provider'a gönderir.
    /// - Parameter data: GameListPresenterOutput.SectionType
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
        let cells = [EmptyTableViewCell.self, GameListHeaderCell.self, GameListItemCell.self]
        self.tableView?.register(cellTypes: cells)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = .none
        self.tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    }
}

extension GameListTableViewProviderImpl {
    /// Provider ile ViewController arasındaki iletişim sırasındaki event'leri tanımlar
    enum UserInteractivity {
        case gameLookup(gameID: String)
    }
}

// MARK: - Provider'ın üstlendiği delegate ve dataSource fonksiyonları
extension GameListTableViewProviderImpl: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = dataList?[section] else { return 0 }
        switch sectionType {
        case .header: return 1
        case .list(let rows, _): return rows.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = dataList?[indexPath.section] else { return UITableViewCell() }
        switch sectionType {
        case .header(let text):
            let cell = tableView.dequeueReusableCell(with: GameListHeaderCell.self, for: indexPath)
            cell.setData(text)
            return cell
        case .list(let rows, _):
            return getCellForRow(tableView, rows: rows, at: indexPath)
        }
    }
    
    private func getCellForRow(_ tableView: UITableView, rows: [GameListPresenterOutput.RowType], at indexPath: IndexPath) -> UITableViewCell {
        let rowType = rows[indexPath.row]
        switch rowType {
        case .game(let entity):
            let cell = tableView.dequeueReusableCell(with: GameListItemCell.self, for: indexPath)
            cell.setData(entity)
            return cell
        case .empty:
            let cell = tableView.dequeueReusableCell(with: EmptyTableViewCell.self, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sectionType = dataList?[indexPath.section] else { return .zero }
        switch sectionType {
        case .list(let rows, _):
            return getHeightForRow(tableView, rows: rows, at: indexPath)
        default:
            return UITableView.automaticDimension
        }
    }
    
    private func getHeightForRow(_ tableView: UITableView, rows: [GameListPresenterOutput.RowType], at indexPath: IndexPath) -> CGFloat {
        let rowType = rows[indexPath.row]
        switch rowType {
        case .game:
            return UITableView.automaticDimension
        case .empty:
            return tableView.bounds.height
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = dataList?[section] else { return nil }
        switch sectionType {
        case .list(_, let header):
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = dataList?[indexPath.section] else { return }
        switch sectionType {
        case .list(let rows, _):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .game(let entity):
                stateClosure?(.updateUI(data: .gameLookup(gameID: entity.id)))
            default:
                break
            }
        default:
            break
        }
    }
}
