//
//  PokemonDetailRequest.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import Foundation

struct PokemonDetailRequest: NetworkTarget {
    
    let id: Int

    var baseURL: BaseURLType {
        .baseApi
    }

    var version: VersionType {
        .v2
    }

    var path: String? {
        "/pokemon/\(id)"
    }

    var methodType: HTTPMethod {
        .get
    }

    var queryParams: [String : String]?
    
    var queryParamsEncoding: URLEncoding? {
        .default
    }
}
