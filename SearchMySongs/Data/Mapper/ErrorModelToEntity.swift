//
//  ErrorModelToEntity.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

class ErrorModelToEntity: Mapper<ErrorModel, ErrorEntity> {
    override func reverseMap(value: ErrorEntity) -> ErrorModel {
        return ErrorModel(message: value.message)
    }
}
