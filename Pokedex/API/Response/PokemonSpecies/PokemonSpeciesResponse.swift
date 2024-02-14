//
//  PokemonSpeciesResponse.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import Foundation

struct PokemonSpeciesResponse: Decodable {

    /// The evolution chain this Pokémon species is a member of.
    let evolutionChain: URLResource
}
