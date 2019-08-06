//
//  DetailViewDatasource.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import UIKit

class DetailViewDatasource: NSObject {
    private var view: DetailViewController?
    var songs = [SongView]() {
        didSet {
            view?.reloadTableView()
        }
    }
    
    func attach(view: DetailViewController) {
        self.view = view
    }
}

extension DetailViewDatasource: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songView = songs[indexPath.row]
        
        switch indexPath.row {
        case 0:// TODO:
            return songCell(tableView, cellForRowAt: indexPath, songView: songView)
        default:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "songCell")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "\(String(songView.trackNumber!)) - \(songView.trackName!)"
            return cell
        }
    }
    
    private func songCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, songView: SongView) -> UITableViewCell {
        let identifier = String(describing: SongTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SongTableViewCell
        
        if (cell == nil) {
            cell = SongTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.setData(
            imageUrl: songView.artworkUrl100 ,
            songTitle: songView.collectionType ?? "",
            albumTitle: songView.collectionName ,
            artisName: songView.artistName
        )
        
        return cell ?? SongTableViewCell()
    }
}
