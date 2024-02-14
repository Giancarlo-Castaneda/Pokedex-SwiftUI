//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import Foundation
import SwiftUI

struct PokemonImageView: View {
    let imageURL: URL

    var body: some View {
        ZStack {
            Image(.pokemonBg)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)
            ImageView(withURL: imageURL)
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    PokemonImageView(imageURL: PokemonImageURLGenerator.generatePosterURL(for: 5)!)
}
