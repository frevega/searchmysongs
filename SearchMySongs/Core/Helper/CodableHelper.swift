//
//  CodableHelper.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import Foundation

class CodableHelper {
    func decodeNetworkObject<D: Decodable>(object: Data) throws -> D {
        do {
            let target = try JSONDecoder().decode(D.self, from: object)
            return target
        } catch {
            throw error
        }
    }
}
