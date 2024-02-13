//
//  SpriteImagesType.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import Foundation

enum SpriteImagesType {
    case frontDefault
    case backDefault
    case frontFemale
    case backFemale
    case frontShiny
    case backShiny
    case frontShinyFemale
    case backShinyFemale

    var title: String {
        switch self {
        case .frontDefault:         return String(localized: "FRONT")
        case .backDefault:          return String(localized: "BACK")
        case .frontFemale:          return String(localized: "FEMALE_FRONT")
        case .backFemale:           return String(localized: "FEMALE_BACK")
        case .frontShiny:           return String(localized: "SHINY_FRONT")
        case .backShiny:            return String(localized: "SHINY_BACK")
        case .frontShinyFemale:     return String(localized: "SHINY_FEMALE_FRONT")
        case .backShinyFemale:      return String(localized: "SHINY_FEMALE_BACK")
        }
    }
}
