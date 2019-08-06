//
//  Presenter.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol Presenter {
    func attach(view: View)
    func fetchSongsBy(term: String)
    func lookupAlbumSongs(id: Int)
}
