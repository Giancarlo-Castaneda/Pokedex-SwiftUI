//
//  EvolutionChainModel.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 13/02/24.
//

import Foundation

protocol EvolutionChainModelProtocol {

    var evolutionChains: [EvolutionChainModel.EvolutionChain] { get }
    var chainType: EvolutionChainModel.ChainType { get }
}

struct EvolutionChainModel: EvolutionChainModelProtocol {
    
    var evolutionChains: [EvolutionChain] {
        var species = [[NamedURLResource]]()
        let firstChain = response.chain
        firstChain.evolvesTo.forEach { secondChain in
            if secondChain.evolvesTo.isEmpty {
                species.append([firstChain.species, secondChain.species])
            } else {
                secondChain.evolvesTo.forEach { thirdChain in
                    species.append([firstChain.species, secondChain.species, thirdChain.species])
                }
            }
        }

        return species.enumerated().map { EvolutionChain($1, id: $0) }
    }

    var chainType: ChainType {
        ChainType(evolutionChains)
    }

    private let response: EvolutionChainResponse

    init(_ evolutionChainResponse: EvolutionChainResponse) {
        response = evolutionChainResponse
    }
}

extension EvolutionChainModel {

    struct EvolutionChain {
        let id: Int
        let pokemons: [PokemonModel]

        init(_ species: [NamedURLResource], id: Int) {
            self.pokemons = species.map { PokemonModel($0) }
            self.id = id
        }
    }
}

extension EvolutionChainModel {

    public enum ChainType {
        case single
        case dual
        case none

        init(_ evolutionChains: [EvolutionChain]) {
            let max = evolutionChains.map { $0.pokemons.count }.max() ?? 0
            switch max {
            case 2:
                self = .single
            case 3:
                self = .dual
            default:
                self = .none
            }
        }
    }
}

extension EvolutionChainModel.ChainType {

    var actionSheetHeight: CGFloat {
        switch self {
        case .single:
            return 350
        case .dual:
            return 430
        case .none:
            return 0
        }
    }
}
