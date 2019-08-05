//
//  ResponseEntity.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

struct ResponseEntity: Codable {
    let resultCount: Int?
    let results: [SongEntity]
}
