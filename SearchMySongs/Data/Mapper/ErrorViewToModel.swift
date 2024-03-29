//
//  ErrorViewToModel.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 05-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

class ErrorViewToModel: Mapper<ErrorView, ErrorModel> {
    override func reverseMap(value: ErrorModel) -> ErrorView {
        return ErrorView(message: value.message)
    }
}
