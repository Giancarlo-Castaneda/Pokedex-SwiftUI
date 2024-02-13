//
//  BaseURLType.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import Foundation

enum BaseURLType {
    case baseApi
    case staging

    var desc: URL? {
        switch self {
        case .baseApi:
            return URL(string: "https://pokeapi.co/api")
        case .staging:
            return URL(string: "https://api.coingecko.com/api")
        }
    }
}
