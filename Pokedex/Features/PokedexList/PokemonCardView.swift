//
//  PokemonCardView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import SwiftUI

struct PokemonCardView: View {

    var pokemon: PokemonModel

    var body: some View {
        VStack(alignment: .leading) {
            if let image = pokemon.image {
                PokemonImageView(imageURL: image)
                    .frame(maxWidth: 150, maxHeight: 200)
            }

            Group {
                Text("NUM_POKEDEX \(pokemon.id)")
                    .foregroundStyle(Color.gray)
                    .font(.body)
                Text(pokemon.name)
                    .lineLimit(1)
                    .font(.title3)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(Color.primary)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.mint.opacity(0.3))
        )
    }
}

#Preview {
    let pokemon = PokemonModel(NamedURLResource(name: "poke", url: PokemonImageURLGenerator.generatePosterURL(for: 13)))

    return PokemonCardView(pokemon: pokemon)
}
