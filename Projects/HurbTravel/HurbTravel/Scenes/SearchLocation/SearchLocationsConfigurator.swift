//
//  SearchLocationsConfigurator.swift
//  HurbTravel
//
//  Created by Matheus Ferreira on 13/06/24.
//

import UIKit

@objc class SearchLocationConfigurator: NSObject {
    
    @objc static func setupArch(viewController: SearchLocationViewController) {
        
        let presenter: SearchLocationPresenter = SearchLocationPresenter(viewController: viewController)
        let interactor: SearchLocationInteractor = SearchLocationInteractor(presenter: presenter, worker: SearchLocationWorker())
        let router: SearchLocationRouter = SearchLocationRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}

