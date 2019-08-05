//
//  SongsDatasource.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol SongsDatasource {
    func search(term: String, limit: Int, completionHandler: @escaping (ResponseEntity?, ErrorEntity?) -> Void)
    func lookup(collectionId: Int, completionHandler: @escaping (ResponseEntity?, ErrorEntity?) -> Void)
}
