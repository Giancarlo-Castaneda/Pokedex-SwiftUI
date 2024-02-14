//
//  EvolutionChainResponse.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 13/02/24.
//

import Foundation

struct EvolutionChainResponse: Decodable {
    
    /// The item that a Pokémon would be holding when mating that would trigger the egg hatching a baby Pokémon rather than a basic Pokémon.
    let babyTriggerItem: NamedURLResource?

    /// The base chain link object. Each link contains evolution details for a Pokémon in the chain. Each link references the next Pokémon in the natural evolution order.
    let chain: ChainLink

    /// The identifier for this resource.
    let id: Int
}

// MARK: - ChainLink
extension EvolutionChainResponse {

    struct ChainLink: Decodable {

        /// All details regarding the specific details of the referenced Pokémon species evolution.
        let evolutionDetails: [EvolutionDetail]

        /// A List of chain objects.
        let evolvesTo: [ChainLink]

        /// Whether or not this link is for a baby Pokémon. This would only ever be true on the base link.
        let isBaby: Bool

        /// The Pokémon species at this point in the evolution chain.
        let species: NamedURLResource
    }
}

// MARK: - EvolutionDetail
extension EvolutionChainResponse {

    struct EvolutionDetail: Decodable {

        /// The type of event that triggers evolution into this Pokémon species.
        let trigger: NamedURLResource?

        /// The id of the gender of the evolving Pokémon species must be in order to evolve into this Pokémon species.
        let gender: Int?

        /// The item the evolving Pokémon species must be holding during the evolution trigger event to evolve into this Pokémon species.
        let heldItem: NamedURLResource?

        /// The item required to cause evolution this into Pokémon species.
        let item: NamedURLResource?

        /// The move that must be known by the evolving Pokémon species during the evolution trigger event in order to evolve into this Pokémon species.
        let knownMove: NamedURLResource?

        /// The evolving Pokémon species must know a move with this type during the evolution trigger event in order to evolve into this Pokémon species.
        let knownMoveType: NamedURLResource?

        /// The location the evolution must be triggered at.
        let location: NamedURLResource?

        /// The minimum required level of affection the evolving Pokémon species to evolve into this Pokémon species.
        let minAffection: Int?

        /// The minimum required level of beauty the evolving Pokémon species to evolve into this Pokémon species.
        let minBeauty: Int?

        /// The minimum required level of happiness the evolving Pokémon species to evolve into this Pokémon species.
        let minHappiness: Int?

        /// The minimum required level of the evolving Pokémon species to evolve into this Pokémon species.
        let minLevel: Int?

        /// Whether or not it must be raining in the overworld to cause evolution this Pokémon species.
        let needsOverworldRain: Bool

        /// The Pokémon species that must be in the players party in order for the evolving Pokémon species to evolve into this Pokémon species.
        let partySpecies: NamedURLResource?

        /// The player must have a Pokémon of this type in their party during the evolution trigger event in order for the evolving Pokémon species to evolve into this Pokémon species.
        let partyType: NamedURLResource?

        /// The required relation between the Pokémon's Attack and Defense stats. 1 means Attack > Defense. 0 means Attack = Defense. -1 means Attack < Defense.
        let relativePhysicalStats: Int?

        /// The required time of day. Day or night.
        let timeOfDay: String?

        /// Pokémon species for which this one must be traded.
        let tradeSpecies: NamedURLResource?

        /// Whether or not the 3DS needs to be turned upside-down as this Pokémon levels up.
        let turnUpsideDown: Bool
    }
}
