import Foundation

protocol PokemonDetailModelProtocol {

    var name: String { get }
    var image: URL? { get }
    var inGameImages: [SpriteImageModel] { get }
    var pokedexNumber: String { get }
    var types: [PokemonTypeModel] { get }
    var weight: String { get }
    var height: String { get }
    var chartData: [ChartData] { get }
}

struct PokemonDetailModel: PokemonDetailModelProtocol {

    // MARK: - Computed Properties

    var name: String {
        pokemonData.name.capitalized
    }

    var image: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonData.id).png")
    }

    var chartData: [ChartData] {
        pokemonData.stats.map { ChartData(type: $0.stat.name.capitalized, value: $0.baseStat) }
    }

    var inGameImages: [SpriteImageModel] {
        [
            (pokemonData.sprites.frontDefault, SpriteImagesType.frontDefault),
            (pokemonData.sprites.backDefault, SpriteImagesType.backDefault),
            (pokemonData.sprites.frontFemale, SpriteImagesType.frontFemale),
            (pokemonData.sprites.backFemale, SpriteImagesType.backFemale),
            (pokemonData.sprites.frontShiny, SpriteImagesType.frontShiny),
            (pokemonData.sprites.backShiny, SpriteImagesType.backShiny),
            (pokemonData.sprites.frontShinyFemale, SpriteImagesType.frontShinyFemale),
            (pokemonData.sprites.backShinyFemale, SpriteImagesType.backShinyFemale)
        ].map { SpriteImageModel(image: $0.0, name: $0.1.title) }.compactMap { $0 }
    }

    var pokedexNumber: String {
        "N.° \(pokemonData.id)"
    }

    var weight: String {
        let double = Double(pokemonData.weight)
        let decimal = NSDecimalNumber(value: double)
        let result = decimal.dividing(by: NSDecimalNumber(value: 10))

        return String(localized: "WEIGHT") + " \(result)" + " Kg"
    }

    var height: String {
        let double = Double(pokemonData.height)
        let decimal = NSDecimalNumber(value: double)
        let result = decimal.dividing(by: NSDecimalNumber(value: 10))

        return String(localized: "HEIGHT") + " \(result)" + " m"
    }

    var types: [PokemonTypeModel] {
        pokemonData.types.map { PokemonTypeModel(type: $0) }
    }

    // MARK: - Private Properties

    private let pokemonData: PokemonData

    // MARK: - Initialization

    init(pokemonData: PokemonData) {
        self.pokemonData = pokemonData
    }
}
