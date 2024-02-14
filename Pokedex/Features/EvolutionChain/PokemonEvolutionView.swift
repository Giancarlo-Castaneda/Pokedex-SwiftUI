//
//  PokemonEvolutionView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import SwiftUI

struct PokemonEvolutionView: View {
    let evolutionChain: EvolutionChainModel

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(evolutionChain.evolutionChains, id: \.id) { count in

                    LazyVGrid(columns: [GridItem(.fixed(300))], spacing: 15) {
                        ForEach(count.pokemons, id: \.id) {
                            PokemonEvolutionCardView(pokemon: $0)
                        }
                    }
                    .containerRelativeFrame(.horizontal)
                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.automatic)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    let big = NamedURLResource(name: "raticate-alola", url: URL(string: "https://pokeapi.co/api/v2/pokemon/10092/"))
    let evoChain = EvolutionChainResponse.ChainLink.init(evolutionDetails: [],
                                                      evolvesTo: [],
                                                      isBaby: false,
                                                      species: big)
    let small = NamedURLResource(name: "rattata-alola", url: URL(string: "https://pokeapi.co/api/v2/pokemon/10091/"))
    let chain = EvolutionChainResponse.ChainLink.init(evolutionDetails: [],
                                                      evolvesTo: [evoChain],
                                                      isBaby: false,
                                                      species: small)
    let completeChain = EvolutionChainModel(.init(babyTriggerItem: nil,
                                             chain: chain,
                                             id: 0))

    return PokemonEvolutionView(evolutionChain: completeChain)
}
