//
//  DealListContracts.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 5.04.2023.
//

import Foundation

// MARK: - VIEW
protocol DealListViewToPresenterProtocol: AnyObject {
    var view: DealListPresenterToViewProtocol? { get set }
    var interactor: DealListPresenterToInteractorProtocol? { get set }
    var router: DealListPresenterToRouterProtocol? { get set }
    
    func load()
    func goToStore(storeBanner: String, storeID: String)
    func goToDealDetail(dealID: String)
}

// MARK: - INTERACTOR
protocol DealListPresenterToInteractorProtocol: AnyObject {
    var presenter: DealListInteractorToPresenterProtocol? { get set }
    var service: APIServiceable { get set }
    
    func load()
}

enum DealListInteractorOutput {
    case data([Store: [Deal]]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol DealListInteractorToPresenterProtocol: AnyObject {
    func handleOutput(_ output: DealListInteractorOutput)
}

// MARK: - PRESENTER {
enum DealListPresenterOutput {
    enum RowType {
        case deal(DealListEntity), empty
    }
    
    case load([RowType]), showLoading(_ show: Bool), showError(_ error: RequestError)
}

protocol DealListPresenterToViewProtocol: AnyObject {
    func handleOutput(_ output: DealListPresenterOutput)
}

// MARK: - ROUTER
enum DealListRoute {
    case goToStore(storeBanner: String, storeID: String), goToDealDetail(dealID: String)
}

protocol DealListPresenterToRouterProtocol: AnyObject {
    var view: BaseViewController? { get set }
    
    static func createModule() -> BaseViewController
    func navigate(_ route: DealListRoute)
}
