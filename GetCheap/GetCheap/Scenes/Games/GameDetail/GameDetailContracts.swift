//
//  GameDetailContracts.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 7.04.2023.
//

import Foundation

// MARK: - VIEW
protocol GameDetailViewToPresenterProtocol: AnyObject {
    var view: GameDetailPresenterToViewProtocol? { get set }
    var interactor: GameDetailPresenterToInteractorProtocol? { get set }
    var router: GameDetailPresenterToRouterProtocol? { get set }
    
    func load()
    func goToGameDeal(dealID: String)
}

// MARK: - INTERACTOR
protocol GameDetailPresenterToInteractorProtocol: AnyObject {
    var presenter: GameDetailInteractorToPresenterProtocol? { get set }
    var service: APIServiceable { get set }
    var gameID: String { get set }
    
    func load()
}

enum GameDetailInteractorOutput {
    case load(data: GameLookup), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol GameDetailInteractorToPresenterProtocol: AnyObject {
    func handleOutput(_ output: GameDetailInteractorOutput)
}

// MARK: - PRESENTER {
enum GameDetailPresenterOutput {
    enum SectionType {
        case head(banner: String, title: String), detail(releaseDate: String, salePrice: String), deals(rows: [RowType])
    }
    
    enum RowType {
        case deal(GameDealEntity)
    }
    
    case load([SectionType]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol GameDetailPresenterToViewProtocol: AnyObject {
    func handleOutput(_ output: GameDetailPresenterOutput)
}

// MARK: - ROUTER
enum GameDetailRoute {
    case goToGameDeal(dealID: String)
}

protocol GameDetailPresenterToRouterProtocol: AnyObject {
    var view: BaseViewController? { get set }
    
    static func createModule(gameID: String) -> BaseViewController
    func navigate(_ route: GameDetailRoute)
}
