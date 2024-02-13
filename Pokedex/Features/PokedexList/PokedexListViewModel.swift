import Combine
import Foundation

final class PokedexListViewModel: ObservableObject {

    // MARK: - Private Properties

    private var totalPokemons = 0
    private var page: Int = 0
    private let perPage: Int = 20
    private let repository: PokedexListRepositoryProtocol
    private let cancelable = Cancelable()

    // MARK: - Internal Properties

    var loadingState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    @Published var pokemonList: [PokemonModel] = []

    // MARK: - Intialization

    init(repository: PokedexListRepositoryProtocol = PokedexListRepository()) {
        self.repository = repository
    }

    // MARK: - Internal Methods

    func getPokemonData() {
        guard page < totalPokemons || page == 0 else { return }
        let publiser = repository.fetch(offset: page, resultLimit: perPage)

        loadingState.send(.loadStart)

        let completionHandler: (Subscribers.Completion<APIError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.loadingState.send(.dismissAlert)
                self?.loadingState.send(.emptyStateHandler(title: error.description, isShow: true))

            case .finished:
                self?.loadingState.send(.dismissAlert)
                break
            }
        }

        let resultValueHandler: (PokedexData) -> Void = { [weak self] data in
            guard let self else { return }

            totalPokemons = data.count
            let pokemons = data.results.map { PokemonModel(pokemonData: $0) }

            self.pokemonList.append(contentsOf: pokemons)
            self.page += pokemons.count
        }

        publiser
            .subscribe(on: WorkScheduler.backgroundWorkScheduler)
            .receive(on: WorkScheduler.mainScheduler)
            .sink(receiveCompletion: completionHandler, receiveValue: resultValueHandler)
            .store(in: cancelable)
    }
}
