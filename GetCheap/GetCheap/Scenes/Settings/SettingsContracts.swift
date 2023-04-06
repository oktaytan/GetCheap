//
//  SettingsContracts.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 6.04.2023.
//

import Foundation

// MARK: - VIEW
protocol SettingsViewToPresenterProtocol: AnyObject {
    var view: SettingsPresenterToViewProtocol? { get set }
    var interactor: SettingsPresenterToInteractorProtocol? { get set }
    var router: SettingsPresenterToRouterProtocol? { get set }
    
    func load()
}

// MARK: - INTERACTOR
protocol SettingsPresenterToInteractorProtocol: AnyObject {
    var presenter: SettingsInteractorToPresenterProtocol? { get set }
    
    func load()
}

enum SettingsInteractorOutput {
    
}

protocol SettingsInteractorToPresenterProtocol: AnyObject {
    func handleOutput(_ output: SettingsInteractorOutput)
}

// MARK: - PRESENTER {
enum SettingsPresenterOutput {
    
}

protocol SettingsPresenterToViewProtocol: AnyObject {
    func handleOutput(_ output: SettingsPresenterOutput)
}

// MARK: - ROUTER
enum SettingsRoute {
    
}

protocol SettingsPresenterToRouterProtocol: AnyObject {
    static func createModule() -> BaseViewController
    func navigate(_ route: SettingsRoute)
}
