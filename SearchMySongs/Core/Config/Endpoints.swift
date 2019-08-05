//
//  Endpoints.swift
//  SearchMySongs
//
//  Created by Freddy Miguel Vega Zárate on 04-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

enum Endpoints {
    enum Prod: String {
        case search = "https://itunes.apple.com/search?term=%@&media=music&entity=song&attribute=songTerm&limit=%d"
        case lookup = "https://itunes.apple.com/lookup?id=%d&entity=song"
    }
}
