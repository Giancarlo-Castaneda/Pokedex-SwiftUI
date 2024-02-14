//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import SwiftUI

struct PokemonDetailView: View {

    private let id: Int

    @State private var showingEvolutionsSheet = false
    @StateObject var detailViewModel: PokemonDetailViewModel = .init()

    init(id: Int) {
        self.id = id
    }

    var body: some View {
        ScrollView {
            VStack {
                if let image = detailViewModel.pokemonDetail.image {
                    PokemonDetailHeader(image: image, 
                                        showEvolutions: $showingEvolutionsSheet,
                                        showEvolutionButton: detailViewModel.isEvolutionAvailable)
                }

                HStack {
                    Text(detailViewModel.pokemonDetail.name)
                        .font(.largeTitle)
                    Text(detailViewModel.pokemonDetail.pokedexNumber)
                        .foregroundStyle(Color.gray)
                        .font(.largeTitle)
                }

                VStack {
                    PokemonTypeView(viewModel: detailViewModel)

                    PokemonStatsView(viewModel: detailViewModel)

                    PokemonInGamePreviewView(viewModel: detailViewModel)
                }
            }
            .onAppear {
                detailViewModel.fetch(id: id)
                detailViewModel.fetchEvolutionChain(id: id)
            }
        }
        .background(Color.purple.opacity(0.3))
        .scrollIndicators(.hidden)
        .sheet(isPresented: $showingEvolutionsSheet) {
            if let chain = detailViewModel.evolutionChain {
                PokemonEvolutionView(evolutionChain: chain)
                    .presentationDetents([.height(chain.chainType.actionSheetHeight)])
            }
        }
    }
}

#Preview {
    PokemonDetailView(id: 133)
}

private struct PokemonDetailHeader: View {
    let image: URL
    @Binding var showEvolutions: Bool
    var showEvolutionButton: Bool

    var body: some View {
        ZStack {
            Image(.pokemonBg)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)
            ImageView(withURL: image)
            if showEvolutionButton {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showEvolutions = true
                        }, label: {
                            Image(.dna)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                        .frame(width: 40, height: 40)
                    }
                    Spacer()
                }
                .padding(.trailing, 20)
            }
        }
        .frame(maxHeight: 300)
    }
}

private struct PokemonStatsView: View {

    @StateObject var viewModel: PokemonDetailViewModel

    var body: some View {
        Group {
            Text("DATA")
                .font(.title)
                .padding(.top, 10)
            HStack {
                Text(viewModel.pokemonDetail.weight)
                    .font(.body)
                Spacer()
                Text(viewModel.pokemonDetail.height)
                    .font(.body)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)

            BarChartView(data: viewModel.pokemonDetail.chartData)
                .padding(.horizontal, 15)
        }
    }
}

private struct PokemonTypeView: View {
    @StateObject var viewModel: PokemonDetailViewModel

    var body: some View {
        Group {
            Text("TYPE")
                .font(.title)
                .padding(.top, 10)
            HStack {
                Spacer()
                ForEach(viewModel.pokemonDetail.types, id: \.id) { element in
                    ChipView(titleKey: element.name, textColor: element.nameColor, colors: element.color)
                }
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
}

private struct PokemonInGamePreviewView: View {
    @StateObject var viewModel: PokemonDetailViewModel

    var body: some View {
        Group {
            Text("INGAME_PREVIEW")
                .font(.title)
                .padding(.top, 10)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.pokemonDetail.inGameImages, id: \.id) { inGame in
                        Spacer()
                        VStack {
                            ImageView(withURL: inGame.image)
                                .background(
                                    RoundedRectangle(cornerRadius: 45)
                                        .fill(Color.gray.opacity(0.3))
                                )
                            Text(inGame.name)
                                .lineLimit(2)
                                .font(.title2)
                        }
                        .frame(height: 180)
                        Spacer()
                    }
                }
            }
            .padding(.top)
            .padding(.bottom, 50)
        }
    }
}
