//
//  ListViewDelegate.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class ListViewDelegate: NSObject {
    private var view: ListViewController?
    
    func attach(view: ListViewController) {
        self.view = view
    }
}

extension ListViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ViewFactory.viewController(viewType: .songDetail) as? DetailViewController
        if let view = view, let viewController = viewController {
            viewController.collectionId = view.songs[indexPath.row].collectionId
            view.pushViewController(viewController: viewController)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
