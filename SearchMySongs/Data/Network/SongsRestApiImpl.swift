//
//  SongsRestApiImpl.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import Alamofire

class SongsRestApiImpl: SongsRestApi {
    private let codableHelper: CodableHelper
    private let errorMessage = "Ups! Something went wrong..."
    
    init(codableHelper: CodableHelper) {
        self.codableHelper = codableHelper
    }
    
    func search(term: String, endpoint: Endpoints.Prod, limit: Int, completionHandler: @escaping ([ResponseEntity]?, ErrorEntity?) -> Void) {
        guard let url = URL(
            string: String(format: Endpoints.Prod.search.rawValue, term, limit)
        ) else {
            completionHandler(nil, ErrorEntity(message: errorMessage))
            return
        }
        
        Alamofire.request(url).responseData { (response) in
            if let data = response.data, let entity: [ResponseEntity] = try? self.codableHelper.decodeNetworkObject(object: data) {
                completionHandler(entity, nil)
            } else {
                completionHandler(nil, ErrorEntity(message: self.errorMessage))
            }
        }
    }
    
    func lookup(collectionId: Int, endpoint: Endpoints.Prod, completionHandler: @escaping ([ResponseEntity]?, ErrorEntity?) -> Void) {
        guard let url = URL(
            string: String(format: Endpoints.Prod.search.rawValue, collectionId)
        ) else {
            completionHandler(nil, ErrorEntity(message: self.errorMessage))
            return
        }
        
        Alamofire.request(url).responseData { (response) in
            if let data = response.data, let entity: [ResponseEntity] = try? self.codableHelper.decodeNetworkObject(object: data) {
                completionHandler(entity, nil)
            } else {
                completionHandler(nil, ErrorEntity(message: self.errorMessage))
            }
        }
    }
}
