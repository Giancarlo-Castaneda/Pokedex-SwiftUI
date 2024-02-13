//
//  PokedexData.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import Foundation

// MARK: - PokedexData

struct PokedexData: Decodable {
    let count: Int
    let next, previous: URL?
    let results: [PokemonGeneralData]
}

// MARK: - PokemonGeneralData

struct PokemonGeneralData: Decodable {
    let name: String
    let url: URL
}
