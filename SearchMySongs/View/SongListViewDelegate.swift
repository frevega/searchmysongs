//
//  SongListViewDelegate.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class SongListViewDelegate: NSObject {
    private var view: SongListViewController?
    
    func attach(view: SongListViewController) {
        self.view = view
    }
}

extension SongListViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
