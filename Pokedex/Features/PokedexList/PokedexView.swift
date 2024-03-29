//
//  PokedexView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import SwiftUI

struct PokedexView: View {

    // MARK: - Private Properties

    private let cancelable = Cancelable()
    private let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 500)),
        GridItem(.adaptive(minimum: 100, maximum: 500))
    ]
    @State private var isLoading = true

    @StateObject var viewModel: PokedexListViewModel = .init()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, content: {
                    ForEach(viewModel.pokemonList, id: \.self) { pokemon in
                        NavigationLink {
                            PokemonDetailView(id: pokemon.id)
                        } label: {
                            PokemonCardView(pokemon: pokemon)
                                .onAppear() {
                                    if viewModel.shouldLoadNewPokemons(for: pokemon) {
                                        viewModel.getPokemonData()
                                    }
                                }
                        }
                    }
                    if isLoading {
                        Text("LOADING")
                    } else {
                        Color.clear
                            .onAppear {
                                if !viewModel.pokemonList.isEmpty {
                                    viewModel.getPokemonData()
                                }
                            }
                    }
                })
            }
            .padding(.horizontal, 5)
            .navigationTitle("POKEDEX")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                handleState()
                viewModel.getPokemonData()
            }
        }
    }
}

#Preview {
    PokedexView(viewModel: PokedexListViewModel())
}

extension PokedexView {

    private func handleState() {
        viewModel.loadingState
            .receive(on: WorkScheduler.mainThread)
            .sink { state in
                switch state {
                case .loadStart:
                    isLoading = true

                case .dismissAlert:
                    isLoading = false

                case .emptyStateHandler:
                    isLoading = false
                }
            }
            .store(in: cancelable)
    }
}
