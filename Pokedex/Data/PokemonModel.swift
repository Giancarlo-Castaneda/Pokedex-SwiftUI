import Foundation

protocol PokemonModelProtocol {
    var id: String { get }
    var image: URL? { get }
    var name: String { get }
}

struct PokemonModel: PokemonModelProtocol {

    // MARK: - Computed Properties

    var id: String {
        String(pokemonData.url?.absoluteString.split(separator: "/").last ?? "")
    }

    var image: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }

    var name: String {
        pokemonData.name
    }

    // MARK: - Private Properties

    private let pokemonData: NamedURLResource

    // MARK: - Initialization

    init(pokemonData: NamedURLResource) {
        self.pokemonData = pokemonData
    }
}
