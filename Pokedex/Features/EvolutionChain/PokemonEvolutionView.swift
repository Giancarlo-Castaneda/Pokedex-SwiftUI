//
//  PokemonEvolutionView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import SwiftUI

struct PokemonEvolutionView: View {
    @Environment(\.dismiss) var dismiss
    let evolutionChain: EvolutionChainModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
            TabView {
                ForEach(evolutionChain.evolutionChains, id: \.id) { count in

                    LazyVGrid(columns: [GridItem(.fixed(300))], spacing: 15) {
                        ForEach(count.pokemons, id: \.id) { current in
                            PokemonEvolutionCardView(pokemon: current)
                        }
                    }
                    .tag(count.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            Button(action: {
                dismiss.callAsFunction()
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .foregroundStyle(Color.darkConstrast)
            })
            .frame(width: 35, height: 35)
            .padding(.trailing, 20)
            .padding(.top, 20)
        }
    }
}

#Preview {
    let big2 = NamedURLResource(name: "raticate-alola", url: URL(string: "https://pokeapi.co/api/v2/pokemon/10089/"))
    let evoChain2 = EvolutionChainResponse.ChainLink.init(evolutionDetails: [],
                                                          evolvesTo: [],
                                                          isBaby: false,
                                                          species: big2)

    let big = NamedURLResource(name: "raticate-alola", url: URL(string: "https://pokeapi.co/api/v2/pokemon/10092/"))
    let evoChain = EvolutionChainResponse.ChainLink.init(evolutionDetails: [],
                                                         evolvesTo: [],
                                                         isBaby: false,
                                                         species: big)
    let small = NamedURLResource(name: "rattata-alola", url: URL(string: "https://pokeapi.co/api/v2/pokemon/10091/"))
    let chain = EvolutionChainResponse.ChainLink.init(evolutionDetails: [],
                                                      evolvesTo: [evoChain, evoChain2],
                                                      isBaby: false,
                                                      species: small)
    let completeChain = EvolutionChainModel(.init(babyTriggerItem: nil,
                                                  chain: chain,
                                                  id: 0))

    return PokemonEvolutionView(evolutionChain: completeChain)
}
