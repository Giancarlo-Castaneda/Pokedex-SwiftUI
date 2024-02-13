//
//  PokemonEvolutionRequest.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 13/02/24.
//

import Foundation

struct PokemonEvolutionRequest: NetworkTarget {

    let id: Int

    var baseURL: BaseURLType {
        .baseApi
    }

    var version: VersionType {
        .v2
    }

    var path: String? {
        "evolution-chain/\(id)"
    }

    var methodType: HTTPMethod {
        .get
    }

    var queryParams: [String : String]?
    
    var queryParamsEncoding: URLEncoding? {
        .default
    }
}
