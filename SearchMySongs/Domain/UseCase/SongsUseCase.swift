//
//  SongsUseCase.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

struct SongsUseCase {
    private let repository: SongsRepository

    init(repository: SongsRepository) {
        self.repository = repository
    }
    
    func searchSongs(term: String, limit: Int, completionHandler: @escaping (ResponseModel?, ErrorModel?) -> Void) {
        repository.search(term: term, limit: limit) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func lookupSongs(collectionId: Int, completionHandler: @escaping (ResponseModel?, ErrorModel?) -> Void) {
        repository.lookup(collectionId: collectionId) { (response, error) in
            completionHandler(response, error)
        }
    }
}
