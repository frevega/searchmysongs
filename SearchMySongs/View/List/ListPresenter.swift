//
//  ListPresenter.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 8/5/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol ListPresenter {
    func attach(view: ListView)
    func fetchSongsBy(term: String)
}
