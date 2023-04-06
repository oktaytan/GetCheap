//
//  SettingsVC.swift
//  GetCheap
//
//  Created by Oktay Tanrıkulu on 4.04.2023.
//

import UIKit

final class SettingsVC: BaseViewController {
    
    var presenter: SettingsViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        setupNavBar(title: "Settings")
    }
    
}


extension SettingsVC: SettingsPresenterToViewProtocol {
    func handleOutput(_ output: SettingsPresenterOutput) {
        
    }
}
