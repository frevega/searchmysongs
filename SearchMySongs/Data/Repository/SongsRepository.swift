//
//  SongsRepository.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

protocol SongsRepository {
    func search(term: String, limit: Int, completionHandler: @escaping (ResponseModel?, ErrorModel?) -> Void)
    func lookup(collectionId: Int, completionHandler: @escaping (ResponseModel?, ErrorModel?) -> Void)
}
