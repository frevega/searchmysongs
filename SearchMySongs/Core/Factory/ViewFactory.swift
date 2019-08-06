//
//  ViewFactory.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 05-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

enum ViewTypes {
    case songList
    case songDetail
}

class ViewFactory {
    private static var serviceLocator = ServiceLocator()
    
    class func viewController(viewType: ViewTypes) -> UIViewController {
        var viewController: UIViewController
        
        switch viewType {
        case .songList:
            viewController = ListViewControllerFactory(serviceLocator: serviceLocator).songListViewController()
        case .songDetail:
            viewController = DetailViewControllerFactory(serviceLocator: serviceLocator).songListViewController()
        }
        
        return viewController
    }
}
