//
//  ListViewDatasource.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class ListViewDatasource: NSObject {
    private var view: ListViewController?
    
    func attach(view: ListViewController) {
        self.view = view
    }
}

extension ListViewDatasource: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let count = view?.songs.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: SongTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SongTableViewCell
        
        if (cell == nil) {
            cell = SongTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        if let songView = view?.songs[indexPath.row] {
            cell?.setData(
                imageUrl: songView.artworkUrl100 ,
                songTitle: songView.trackName ?? "",
                albumTitle: songView.collectionName ,
                artisName: songView.artistName 
            )
            
            return cell ?? SongTableViewCell()
        } else {
            return UITableViewCell()
        }
    }
}
