//
//  StoreDetailContracts.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

// MARK: - VIEW
protocol StoreDetailViewToPresenterProtocol: AnyObject {
    var view: StoreDetailPresenterToViewProtocol? { get set }
    var interactor: StoreDetailPresenterToInteractorProtocol? { get set }
    var router: StoreDetailPresenterToRouterProtocol? { get set }
    
    func load()
    func goToDealDetail(dealID: String)
}

// MARK: - INTERACTOR
protocol StoreDetailPresenterToInteractorProtocol: AnyObject {
    var presenter: StoreDetailInteractorToPresenterProtocol? { get set }
    var service: APIServiceable { get set }
    
    func load()
}

enum StoreDetailInteractorOutput {
    case data(banner: String, deals: [Deal]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol StoreDetailInteractorToPresenterProtocol: AnyObject {
    func handleOutput(_ output: StoreDetailInteractorOutput)
}

// MARK: - PRESENTER {
enum StoreDetailPresenterOutput {
    enum ItemType {
        case deals(DealEntity), empty
    }
    
    case load(banner: String, deals: [ItemType]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol StoreDetailPresenterToViewProtocol: AnyObject {
    func handleOutput(_ output: StoreDetailPresenterOutput)
}

// MARK: - ROUTER
enum StoreDetailRoute {
    case goToDealDetail(dealID: String)
}

protocol StoreDetailPresenterToRouterProtocol: AnyObject {
    static func createModule(storeID: String, storeBanner: String) -> BaseViewController
    func navigate(_ route: StoreDetailRoute)
}
