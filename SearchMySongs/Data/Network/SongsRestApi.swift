//
//  SongsRestApi.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol SongsRestApi {
    func search(term: String, endpoint: Endpoints.Prod, limit: Int, completionHandler: @escaping (ResponseEntity?, ErrorEntity?) -> Void)
    func lookup(collectionId: Int, endpoint: Endpoints.Prod, completionHandler: @escaping (ResponseEntity?, ErrorEntity?) -> Void)
}
