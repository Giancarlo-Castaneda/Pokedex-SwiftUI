//
//  PokemonType.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import Foundation
import SwiftUI

enum PokemonType: String {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
}

extension PokemonType {

    var localized: String {
        switch self {
        case .normal:       return String(localized: "NORMAL")
        case .fighting:     return String(localized: "FIGHTING")
        case .flying:       return String(localized: "FLYING")
        case .poison:       return String(localized: "POISON")
        case .ground:       return String(localized: "GROUND")
        case .rock:         return String(localized: "ROCK")
        case .bug:          return String(localized: "BUG")
        case .ghost:        return String(localized: "GHOST")
        case .steel:        return String(localized: "STEEL")
        case .fire:         return String(localized: "FIRE")
        case .water:        return String(localized: "WATER")
        case .grass:        return String(localized: "GRASS")
        case .electric:     return String(localized: "ELECTRIC")
        case .psychic:      return String(localized: "PSYCHIC")
        case .ice:          return String(localized: "ICE")
        case .dragon:       return String(localized: "DRAGON")
        case .dark:         return String(localized: "DARK")
        case .fairy:        return String(localized: "FAIRY")
        }
    }

    var textColor: Color {
        switch self {
        case .flying,
            .grass,
            .normal,
            .electric,
            .ground,
            .fairy,
            .steel,
            .ice:
            return .black

        case .fire,
            .water,
            .poison,
            .bug,
            .fighting,
            .psychic,
            .rock,
            .ghost,
            .dark,
            .dragon:
            return .white
        }
    }

    var color: [Color] {
        switch self {
        case .normal:       return [Color.normalType]
        case .fighting:     return [Color.fightingType]
        case .flying:       return [Color.iceFlyingType1, Color.flyingType2]
        case .poison:       return [Color.poisonType]
        case .ground:       return [Color.groundType1,Color.groundType2]
        case .rock:         return [Color.rockType]
        case .bug:          return [Color.bugType]
        case .ghost:        return [Color.ghostType]
        case .steel:        return [Color.steelType]
        case .fire:         return [Color.fireType]
        case .water:        return [Color.waterType]
        case .grass:        return [Color.grassType]
        case .electric:     return [Color.electricType]
        case .psychic:      return [Color.psychicType]
        case .ice:          return [Color.iceFlyingType1]
        case .dragon:       return [Color.dragonType1, Color.dragonType2]
        case .dark:         return [Color.darkType]
        case .fairy:        return [Color.fairyType]
        }
    }
}
