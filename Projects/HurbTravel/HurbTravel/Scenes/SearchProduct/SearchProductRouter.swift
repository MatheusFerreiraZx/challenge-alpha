//
//  SearchProductRouter.swift
//  HurbTravel
//
//  Created by Matheus Ferreira on 13/06/24.
//

import UIKit

// Private segues names
private enum Segues: String {
    case toDetails
}

@objc protocol SearchProductRoutingLogic {
    
    func routeTo(segue: UIStoryboardSegue, sender: Any?)
    func navigateToDetails()
}

protocol SearchProductDataPassing {
    
    var dataStore: SearchProductDataStore? { get }
}

class SearchProductRouter: NSObject, SearchProductRoutingLogic, SearchProductDataPassing {
    
    weak var viewController: SearchProductViewController?
    var dataStore: SearchProductDataStore?
    
    init(viewController: SearchProductViewController, dataStore: SearchProductDataStore) {
        
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Routing
    
    func routeTo(segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {

        case Segues.toDetails.rawValue:
            if let nextController: ProductDetailsViewController = segue.destination as? ProductDetailsViewController {

                ProductDetailsConfigurator.setupArch(viewController: nextController)
                
                if let sourceDataStore: SearchProductDataStore = self.dataStore,
                   var destinationDataSource: ProductDetailsDataStore = nextController.router?.dataStore {

                    destinationDataSource.product = sourceDataStore.product
                }
            }
            break

        default:
            break
        }
    }
    
    func navigateToDetails() {
        
        self.viewController?.performSegue(withIdentifier: Segues.toDetails.rawValue, sender: nil)
    }
}

