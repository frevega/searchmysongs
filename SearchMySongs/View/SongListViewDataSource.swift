//
//  SongListViewDatasource.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class SongListViewDatasource: NSObject {
    private var view: SongListViewController?
    var songs = [SongView]() {
        didSet {
            view?.reloadTableView()
        }
    }
    
    func attach(view: SongListViewController) {
        self.view = view
    }
}

extension SongListViewDatasource: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: SongTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SongTableViewCell
        
        if (cell == nil) {
            cell = SongTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let songView = songs[indexPath.row]
        cell?.setData(
            imageUrl: songView.artworkUrl100 ?? "",
            songTitle: songView.trackName ?? "",
            albumTitle: songView.collectionName ?? "",
            artisName: songView.artistName ?? ""
        )
        
        return cell ?? SongTableViewCell()
    }
}
