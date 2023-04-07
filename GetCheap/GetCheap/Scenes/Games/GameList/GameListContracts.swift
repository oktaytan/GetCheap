//
//  GameListContracts.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

// MARK: - VIEW
protocol GameListViewToPresenterProtocol: AnyObject {
    var view: GameListPresenterToViewProtocol? { get set }
    var interactor: GameListPresenterToInteractorProtocol? { get set }
    var router: GameListPresenterToRouterProtocol? { get set }
    
    func load()
    func popular()
    func search(title: String)
    func goToGameDetail(gameID: String)
}

// MARK: - INTERACTOR
protocol GameListPresenterToInteractorProtocol: AnyObject {
    var presenter: GameListInteractorToPresenterProtocol? { get set }
    var service: APIServiceable { get set }
    
    func popular(gameIDs: [String])
    func search(title: String)
}

enum GameListInteractorOutput {
    case popular(data: [MultipleGameItem]), search(data: [Game]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol GameListInteractorToPresenterProtocol: AnyObject {
    func handleOutput(_ output: GameListInteractorOutput)
}

// MARK: - PRESENTER {
enum GameListPresenterOutput {
    enum SectionType {
        case header(String), list(rows: [RowType], header: String)
    }
    
    enum RowType {
        case game(GameEntity), empty
    }
    
    case load([SectionType]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol GameListPresenterToViewProtocol: AnyObject {
    func handleOutput(_ output: GameListPresenterOutput)
}

// MARK: - ROUTER
enum GameListRoute {
    case goToGameDetail(gameID: String)
}

protocol GameListPresenterToRouterProtocol: AnyObject {
    var view: BaseViewController? { get set }
    
    static func createModule() -> BaseViewController
    func navigate(_ route: GameListRoute)
}
