//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import SwiftUI

struct PokemonDetailView: View {

    private let id: Int

    @StateObject var detailViewModel: PokemonDetailViewModel = .init()

    init(id: Int) {
        self.id = id
    }

    var body: some View {
        ScrollView {
            VStack {
                if let image = detailViewModel.pokemonDetail.image {
                    ZStack(alignment: .centerLastTextBaseline) {
                        Image(.pokemonBg)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0.3)
                        ImageView(withURL: image)
                        HStack {
                            Spacer()
                            Image(systemName: "play.circle")
                                .resizable()
                                .foregroundStyle(Color.mint)
                                .frame(width: 60.0, height: 60.0)
                        }
                        .padding(.trailing)
                    }
                    .frame(maxHeight: 300)
                }

                HStack {
                    Text(detailViewModel.pokemonDetail.name)
                        .font(.largeTitle)
                    Text(detailViewModel.pokemonDetail.pokedexNumber)
                        .foregroundStyle(Color.gray)
                        .font(.largeTitle)
                }

                Text("DATA")
                    .font(.title)
                    .padding(.top, 10)
                HStack {
                    Text(detailViewModel.pokemonDetail.weight)
                        .font(.body)
                    Spacer()
                    Text(detailViewModel.pokemonDetail.height)
                        .font(.body)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 10)

                Text("TYPE")
                    .font(.title)
                    .padding(.top, 10)
                HStack {
                    ForEach(detailViewModel.pokemonDetail.types, id: \.id) { element in
                        ChipView(titleKey: element.name, textColor: element.nameColor, colors: element.color)
                    }
                }

                Text("INGAME_PREVIEW")
                    .font(.title)
                    .padding(.top, 10)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(detailViewModel.pokemonDetail.inGameImages, id: \.id) { inGame in
                            Spacer()
                            VStack {
                                ImageView(withURL: inGame.image)
                                    .background(
                                        RoundedRectangle(cornerRadius: 45)
                                            .fill(Color.gray.opacity(0.3))
                                    )
                                Text(inGame.name)
                                    .font(.title2)
                            }
                            .frame(height: 180)
                            Spacer()
                        }
                    }
                }
                .padding(.vertical)
            }
            .onAppear {
                detailViewModel.fetch(id: id)
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    PokemonDetailView(id: 454)
}
