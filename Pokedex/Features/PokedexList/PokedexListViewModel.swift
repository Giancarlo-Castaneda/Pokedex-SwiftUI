import Combine
import Foundation

final class PokedexListViewModel: DefaultViewModel {

    // MARK: - Private Properties

    private var totalPokemons = 0
    private var page: Int = 0
    private let perPage: Int = 30
    private var fetchingAPI = false
    private let repository: PokedexListRepositoryProtocol

    // MARK: - Internal Properties

    @Published var pokemonList: [PokemonModel] = []

    // MARK: - Intialization

    init(repository: PokedexListRepositoryProtocol = PokedexListRepository()) {
        self.repository = repository
    }


    // MARK: - Internal Methods

    func shouldLoadNewPokemons(for pokemonOnScreen: PokemonModel) -> Bool {
        let currentPosition = pokemonList.firstIndex { $0 == pokemonOnScreen } ?? 0
        let totalLoadedPokemons = pokemonList.count
        let pokemonsNotShown = totalLoadedPokemons - (currentPosition + 1)

        return pokemonsNotShown <= 10
    }

    func getPokemonData() {
        guard (page < totalPokemons || page == 0) && !fetchingAPI else { return }
        fetchingAPI = true
        let publisher = repository.fetch(offset: page, resultLimit: perPage)

        callWithProgress(argument: publisher) { [weak self] data in
            guard let self else { return }

            totalPokemons = data.count
            let pokemons = data.results.map { PokemonModel($0) }

            page += pokemons.count
            pokemonList.append(contentsOf: pokemons)
            fetchingAPI = false
        }
    }
}
