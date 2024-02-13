//
//  EvolutionData.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 13/02/24.
//

import Foundation

// MARK: - EvolutionData
struct EvolutionData: Codable {
    let chain: Chain
    let id: Int

    enum CodingKeys: String, CodingKey {
        case chain, id
    }
}

// MARK: - Chain
struct Chain: Codable {
    let evolutionDetails: [EvolutionDetail]
    let evolvesTo: [Chain]
    let isBaby: Bool
    let species: Species

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail
struct EvolutionDetail: Codable {
    let gender:Int
    let minHappiness, minBeauty, minAffection, relativePhysicalStats: Int?
    let minLevel: Int
    let needsOverworldRain: Bool
    let timeOfDay: String
    let tradeSpecies, partySpecies: Species?
    let trigger: Species
    let turnUpsideDown: Bool

    enum CodingKeys: String, CodingKey {
        case gender
        case minAffection = "min_affection"
        case minBeauty = "min_beauty"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case partySpecies = "party_species"
        case relativePhysicalStats = "relative_physical_stats"
        case timeOfDay = "time_of_day"
        case tradeSpecies = "trade_species"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}
