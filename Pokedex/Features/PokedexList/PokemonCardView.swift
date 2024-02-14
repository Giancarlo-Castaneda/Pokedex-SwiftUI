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
        ZStack {
            Image(.pokemonBg)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)
            VStack {
                if let image = pokemon.image {
                    ImageView(withURL: image)
                }
                Text(pokemon.name.capitalized)
                    .font(.title2)
                    .foregroundStyle(Color.primary)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.mint.opacity(0.3))
        )
    }
}

#Preview {
    PokemonCardView(pokemon: PokemonModel(pokemonData: NamedURLResource(name: "poke", url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10277.png")!)))
}
