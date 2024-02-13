import Combine
import Foundation

final class PokedexListViewModel: DefaultViewModel {

    // MARK: - Private Properties

    private var totalPokemons = 0
    private var page: Int = 0
    private let perPage: Int = 20
    private let repository: PokedexListRepositoryProtocol

    // MARK: - Internal Properties

    @Published var pokemonList: [PokemonModel] = []

    // MARK: - Intialization

    init(repository: PokedexListRepositoryProtocol = PokedexListRepository()) {
        self.repository = repository
    }

    // MARK: - Internal Methods

    func getPokemonData() {
        guard page < totalPokemons || page == 0 else { return }
        let publiser = repository.fetch(offset: page, resultLimit: perPage)

        callWithProgress(argument: publiser) { [weak self] data in
            guard let self else { return }

            totalPokemons = data.count
            let pokemons = data.results.map { PokemonModel(pokemonData: $0) }

            pokemonList.append(contentsOf: pokemons)
            page += pokemons.count
        }
    }
}
