//
//  SearchProductInteractor.swift
//  HurbTravel
//
//  Created by Matheus Ferreira on 13/06/24.
//

import UIKit

protocol SearchProductBusinessLogic {
    
    func searchProducts(request: SearchProduct.Query.Request)
    func didSeletedProduct(request: SearchProduct.Selection.Request)
}

protocol SearchProductDataStore {
    
    var product: Product? { get set }
}

class SearchProductInteractor: SearchProductBusinessLogic, SearchProductDataStore {
    
    var presenter: SearchProductPresentationLogic?
    var worker: SearchProductWorkerProtocol?

    var product: Product?

    init(presenter: SearchProductPresentationLogic, worker: SearchProductWorkerProtocol) {
        
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: Do something
    
    func searchProducts(request: SearchProduct.Query.Request) {
        
        self.worker?.searchProducts(term: request.term, page: request.page, limit: request.limit, completion: { result in
            
            switch result {
                    
                case .success(let container):
                    
                    if let products: [Product] = container.products, products.count > 0 {
                        
                        let response: SearchProduct.Query.Response = SearchProduct.Query.Response(pagination: container.pagination, products: products)
                        self.presenter?.presentNewProducts(response: response)
                    } else if request.page <= 1 {
                        
                        self.presenter?.presentNoSearchResultsView()
                    }
                    break
                    
                case .failure( _):
                    self.presenter?.presentErrorAlert()
                    break
            }
        })
    }
    
    func didSeletedProduct(request: SearchProduct.Selection.Request) {
        
        self.product = request.product
        
        self.presenter?.presentProductDetails()
    }
}

