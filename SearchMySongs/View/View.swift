//
//  View.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol View: class {
    func prepare()
    func showLoading()
    func hideLoading()
    func show(songs: [SongView])
    func show(album: [SongView])
    func show(error: ErrorView)
}
