//
//  StoreListContracts.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

// MARK: - VIEW
protocol StoreListViewToPresenterProtocol: AnyObject {
    var view: StoreListPresenterToViewProtocol? { get set }
    var interactor: StoreListPresenterToInteractorProtocol? { get set }
    var router: StoreListPresenterToRouterProtocol? { get set }
    
    func load()
    func goToStore(storeBanner: String, storeID: String)
}

// MARK: - INTERACTOR
protocol StoreListPresenterToInteractorProtocol: AnyObject {
    var presenter: StoreListInteractorToPresenterProtocol? { get set }
    var service: APIServiceable { get set }
    
    func load()
}

enum StoreListInteractorOutput {
    case data([Store]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol StoreListInteractorToPresenterProtocol: AnyObject {
    func handleOutput(_ output: StoreListInteractorOutput)
}

// MARK: - PRESENTER {
enum StoreListPresenterOutput {
    enum RowType {
        case store(StoreListEntity), empty
    }
    
    case load([RowType]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol StoreListPresenterToViewProtocol: AnyObject {
    func handleOutput(_ output: StoreListPresenterOutput)
}

// MARK: - ROUTER
enum StoreListRoute {
    case goToStore(storeBanner: String, storeID: String)
}

protocol StoreListPresenterToRouterProtocol: AnyObject {
    var view: BaseViewController? { get set }
    
    static func createModule() -> BaseViewController
    func navigate(_ route: StoreListRoute)
}
