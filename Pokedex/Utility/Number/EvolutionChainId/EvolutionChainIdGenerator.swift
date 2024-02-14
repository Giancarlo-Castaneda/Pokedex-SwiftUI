//
//  EvolutionChainIdGenerator.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import Foundation

enum EvolutionChainIdGenerator {

    static func generate(from url: String) -> Int? {
        var removePrefix = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/evolution-chain/", with: "")
        removePrefix.removeLast()
        return Int(removePrefix)
    }
}
