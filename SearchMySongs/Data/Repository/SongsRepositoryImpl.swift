//
//  SongsRepositoryImpl.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import Foundation

class SongsRepositoryImpl: SongsRepository {
    private let datasource: SongsDatasource
    private let responseModelToEntity: ResponseModelToEntity
    private let errorModelToEntity: ErrorModelToEntity
    
    init(datasource: SongsDatasource,
         responseModelToEntity: ResponseModelToEntity,
         errorModelToEntity: ErrorModelToEntity
    ) {
        self.datasource = datasource
        self.responseModelToEntity = responseModelToEntity
        self.errorModelToEntity = errorModelToEntity
    }
    
    func search(term: String, limit: Int, completionHandler: @escaping (ResponseModel?, ErrorModel?) -> Void) {
        datasource.search(term: term, limit: limit) { (response, error) in
            if let response = response {
                completionHandler(self.responseModelToEntity.reverseMap(value: response), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            }
        }
    }
    
    func lookup(collectionId: Int, completionHandler: @escaping (ResponseModel?, ErrorModel?) -> Void) {
        datasource.lookup(collectionId: collectionId) { (response, error) in
            if let response = response {
                completionHandler(self.responseModelToEntity.reverseMap(value: response), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            }
        }
    }
}
