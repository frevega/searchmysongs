//
//  SongListViewControllerFactory.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class SongListViewControllerFactory {
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
    
    func songListViewController() -> UIViewController {
        let presenter = PresenterImpl(
            useCase: serviceLocator.songsUseCase,
            songViewToModel: serviceLocator.songViewToModel,
            errorViewToModel: serviceLocator.errorViewToModel
        )
        let delegate = SongListViewDelegate()
        let datasource = SongListViewDatasource()
        
        let viewController = SongListViewController(
            presenter: presenter,
            delegate: delegate,
            datasource: datasource
        )
        
        return viewController
    }
}
