//
//  ListViewControllerFactory.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class ListViewControllerFactory {
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    func songListViewController() -> UIViewController {
        let presenter = ListPresenterImpl(
            useCase: serviceLocator.songsUseCase,
            songViewToModel: serviceLocator.songViewToModel,
            errorViewToModel: serviceLocator.errorViewToModel
        )
        let delegate = ListViewDelegate()
        let datasource = ListViewDatasource()
        
        let viewController = ListViewController(
            presenter: presenter,
            delegate: delegate,
            datasource: datasource
        )
        
        return viewController
    }
}
