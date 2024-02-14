//
//  PokemonSpeciesRequest.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import Foundation

struct PokemonSpeciesRequest: NetworkTarget {

    private let pokemonId: Int

    init(pokemonId: Int) {
        self.pokemonId = pokemonId
    }

    var baseURL: BaseURLType {
        .baseApi
    }

    var version: VersionType {
        .v2
    }

    var path: String? {
        "/pokemon-species/\(pokemonId)"
    }

    var methodType: HTTPMethod {
        .get
    }

    var queryParams: [String : String]?
    
    var queryParamsEncoding: URLEncoding?
}
