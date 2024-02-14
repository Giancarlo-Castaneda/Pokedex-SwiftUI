import Foundation

struct PokemonDetailResponse: Decodable {

    /// A list of abilities this Pokémon could potentially have.
    let abilities: [PokemonAbility]

    /// The base experience gained for defeating this Pokémon.
    let baseExperience: Int?

    /// A list of forms this Pokémon can take on.
    let forms: [NamedURLResource]

    /// A list of game indices relevent to Pokémon item by generation.
    let gameIndices: [VersionGameIndex]

    /// The height of this Pokémon in decimetres.[1dm = 10cm]
    let height: Int

    /// The weight of this Pokémon in hectograms.[1hg = 100g])
    let weight: Int

    /// The identifier for this resource.
    let id: Int

    /// A list of items this Pokémon may be holding when encountered.
    let heldItems: [HeldItem]

    /// Set for exactly one Pokémon used as the default for each species.
    let isDefault: Bool

    /// A link to a list of location areas, as well as encounter details pertaining to specific versions.
    let locationAreaEncounters: String

    /// A list of moves along with learn methods and level details pertaining to specific version groups.
    let moves: [PokemonMove]

    /// The name for this resource.
    let name: String

    /// Order for sorting. Almost national order, except families are grouped together.
    let order: Int

    /// A set of sprites used to depict this Pokémon in the game.
    let sprites: Sprite

    /// The species this Pokémon belongs to.
    let species: NamedURLResource

    /// A list of base stat values for this Pokémon.
    let stats: [PokemonStat]

    /// A list of details showing types this Pokémon has.
    let types: [PokemonType]
}

extension PokemonDetailResponse {

    static let mock = PokemonDetailResponse(abilities: [],
                                            baseExperience: nil,
                                            forms: [],
                                            gameIndices: [],
                                            height: 0,
                                            weight: 0,
                                            id: 0,
                                            heldItems: [],
                                            isDefault: false,
                                            locationAreaEncounters: "",
                                            moves: [],
                                            name: "",
                                            order: 0,
                                            sprites: .init(backDefault: nil, backShiny: nil, backFemale: nil, backShinyFemale: nil, frontDefault: nil, frontShiny: nil, frontFemale: nil, frontShinyFemale: nil),
                                            species: .init(name: "", url: nil),
                                            stats: [],
                                            types: [])
}

// MARK: - PokemonAbility
extension PokemonDetailResponse {

    struct PokemonAbility: Decodable {

        /// The ability the Pokémon may have.
        let ability: NamedURLResource

        /// Whether or not this is a hidden ability.
        let isHidden: Bool

        /// The slot this ability occupies in this Pokémon species.
        let slot: Int
    }
}

// MARK: - HeldItem
extension PokemonDetailResponse {

    struct HeldItem: Decodable {

        /// The item the referenced Pokémon holds.
        let item: NamedURLResource

        /// The details of the different versions in which the item is held.
        let versionDetails: [VersionDetail]
    }
}

// MARK: - VersionDetail
extension PokemonDetailResponse.HeldItem {

    struct VersionDetail: Decodable {

        /// How often the item is held.
        let rarity: Int

        /// The version in which the item is held.
        let version: NamedURLResource
    }
}

// MARK: - PokemonMove
extension PokemonDetailResponse {

    struct PokemonMove: Decodable {

        /// The move the Pokémon can learn.
        let move: NamedURLResource?

        /// The details of the version in which the Pokémon can learn the move.
        let versionGroupDetails: [VersionGroupDetail]
    }
}

// MARK: - VersionGroupDetail
extension PokemonDetailResponse.PokemonMove {

    struct VersionGroupDetail: Decodable {

        /// The minimum level to learn the move.
        let levelLearnedAt: Int

        /// The method by which the move is learned.
        let moveLearnMethod: NamedURLResource

        /// The version group in which the move is learned.
        let versionGroup: NamedURLResource
    }
}

// MARK: - Sprite
extension PokemonDetailResponse {

    struct Sprite: Decodable {

        /// The default depiction of this Pokémon from the back in battle.
        let backDefault: URL?

        /// The shiny depiction of this Pokémon from the back in battle.
        let backShiny: URL?

        /// The female depiction of this Pokémon from the back in battle.
        let backFemale: URL?

        /// The shiny female depiction of this Pokémon from the back in battle.
        let backShinyFemale: URL?

        /// The default depiction of this Pokémon from the front in battle.
        let frontDefault: URL?

        /// The shiny depiction of this Pokémon from the front in battle.
        let frontShiny: URL?

        /// The female depiction of this Pokémon from the front in battle.
        let frontFemale: URL?

        /// The shiny female depiction of this Pokémon from the front in battle.
        let frontShinyFemale: URL?
    }
}

// MARK: - PokemonStat
extension PokemonDetailResponse {

    struct PokemonStat: Decodable {

        /// The stat the Pokémon has.
        let stat: NamedURLResource

        /// The base value of the stat.
        let baseStat: Int

        /// The effort points (EV) the Pokémon has in the stat.
        let effort: Int
    }
}

// MARK: - PokemonType
extension PokemonDetailResponse {

    struct PokemonType: Decodable {

        /// The order the Pokémon's types are listed in.
        let slot: Int

        /// The type the referenced Pokémon has.
        let type: NamedURLResource
    }
}
