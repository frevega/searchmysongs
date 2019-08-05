//
//  SongsDatasourceImpl.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

class SongsDatasourceImpl: SongsDatasource {
    private let restApi: SongsRestApi
    
    init(restApi: SongsRestApi) {
        self.restApi = restApi
    }
    
    func search(term: String, limit: Int, completionHandler: @escaping (ResponseEntity?, ErrorEntity?) -> Void) {
        restApi.search(term: term, endpoint: Endpoints.Prod.search, limit: limit) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func lookup(collectionId: Int, completionHandler: @escaping (ResponseEntity?, ErrorEntity?) -> Void) {
        restApi.lookup(collectionId: collectionId, endpoint: Endpoints.Prod.lookup) { (response, error) in
            completionHandler(response, error)
        }
    }
}
