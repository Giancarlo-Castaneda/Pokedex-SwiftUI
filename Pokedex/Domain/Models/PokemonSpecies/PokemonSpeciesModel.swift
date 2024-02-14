//
//  PokemonSpeciesModel.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import Foundation

struct PokemonSpeciesModel {

    let evolutionChainId: Int

    init(_ response: PokemonSpeciesResponse) {
        evolutionChainId = EvolutionChainIdGenerator.generate(from: response.evolutionChain.url?.absoluteString ?? "") ?? 0
    }
}
