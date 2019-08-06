//
//  DetailPresenter.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/6/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol DetailPresenter {
    func attach(view: DetailView)
    func lookupAlbumSongs(id: Int)
}
