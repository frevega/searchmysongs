//
//  Mapper.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

import Foundation

class Mapper<From, To> {
    func map(value _: From) -> To {
        fatalError("Not Implemented")
    }
    
    func reverseMap(value _: To) -> From {
        fatalError("Must override")
    }
    
    func map(values: [From]) -> [To] {
        var newValues = [To]()
        values.forEach { value in
            newValues.append(map(value: value))
        }
        return newValues
    }
    
    func reverseMap(values: [To]) -> [From] {
        var newValues = [From]()
        values.forEach { value in
            newValues.append(reverseMap(value: value))
        }
        return newValues
    }
}
