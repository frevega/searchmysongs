//
//  DetailView.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/6/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol DetailView: class {
    func prepare()
    func showLoading()
    func hideLoading()
    func show(album: [SongView])
    func show(error: ErrorView)
}
