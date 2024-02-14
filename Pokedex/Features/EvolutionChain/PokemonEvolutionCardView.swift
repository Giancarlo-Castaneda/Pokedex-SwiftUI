//
//  PokemonEvolutionCardView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import SwiftUI

struct PokemonEvolutionCardView: View {
    let pokemon: PokemonModel

    var body: some View {
        HStack {
            ZStack {
                Image(.pokemonBg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .frame(height: 100)
                if let image = pokemon.image {
                    ImageView(withURL: image)
                        .frame(height: 80)
                }
            }
            VStack(alignment: .leading) {
                Text(pokemon.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text("No.º \(pokemon.id)")
                    .font(.caption)
            }
        }
        .frame(width: 280)
        .background {
            RoundedRectangle(cornerRadius: 70, style: .continuous)
                .fill(Color.white)
        }
        .shadow(color: .black.opacity(0.1), radius: 25)
    }
}

#Preview {
    PokemonEvolutionCardView(pokemon: .init(.init(name: "rattata-alola", url: URL(string: "https://pokeapi.co/api/v2/pokemon/10091/"))))
}
