//
//  DetailViewDelegate.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class DetailViewDelegate: NSObject {
    private var view: DetailViewController?
    
    func attach(view: DetailViewController) {
        self.view = view
    }
}

extension DetailViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
