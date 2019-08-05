//
//  ResponseModelToEntity.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

class ResponseModelToEntity: Mapper<ResponseModel, ResponseEntity> {
    private let songModelToEntity: SongModelToEntity
    
    init(songModelToEntity: SongModelToEntity) {
        self.songModelToEntity = songModelToEntity
    }
    
    override func reverseMap(value: ResponseEntity) -> ResponseModel {
        return ResponseModel(resultCount: value.resultCount,
                             results: songModelToEntity.reverseMap(values: value.results)
        )
    }
}
