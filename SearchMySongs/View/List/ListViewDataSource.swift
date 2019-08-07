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
            return count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:// TODO:
            return searchCell(tableView, cellForRowAt: indexPath)
        default:
            return songCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func searchCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: TextFieldTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TextFieldTableViewCell
        
        if (cell == nil) {
            cell = TextFieldTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        if let view = view {
            cell?.setup(delegate: view)
            return cell ?? TextFieldTableViewCell()
        } else {
            return UITableViewCell()
        }
    }
    
    private func songCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: SongTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SongTableViewCell
        
        if (cell == nil) {
            cell = SongTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        if view?.songs != nil, let songView = view?.songs[indexPath.row - 1] {
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
