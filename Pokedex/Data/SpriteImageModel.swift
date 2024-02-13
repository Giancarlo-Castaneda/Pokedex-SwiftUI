//
//  SpriteImageModel.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import Foundation

struct SpriteImageModel: Identifiable {

    let id = UUID()
    let image: URL
    let name: String

    init?(image: URL?, name: String) {
        guard let validImage = image else { return nil }
        self.image = validImage
        self.name = name
    }
}
