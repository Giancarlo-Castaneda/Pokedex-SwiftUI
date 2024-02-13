//
//  PokemonEvolutionModel.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 13/02/24.
//

import Foundation

protocol PokemonEvolutionModelProtocol {

    var evolutionDetail: Int? { get }
    var image: URL? { get }
    var name: String { get }
}

struct PokemonEvolutionModel: PokemonEvolutionModelProtocol {

    var evolutionDetail: Int? {
        0
    }

    var image: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonId).png")
    }

    var name: String {
        chainData.species.name
    }

    private let chainData: Chain
    private let pokemonId: Int

    init(chainData: Chain, pokemonId: Int = 0) {
        self.chainData = chainData
        self.pokemonId = pokemonId
    }
}
