import Combine
import Foundation

final class PokemonDetailViewModel: ObservableObject {

    private let repository: PokemonDetailRepositoryProtocol
    private let cancelable = Cancelable()

    @Published private(set) var pokemonDetail = PokemonDetailModel(pokemonData: .mock)

    init(repository: PokemonDetailRepositoryProtocol = PokemonDetailRepository()) {
        self.repository = repository
    }

    func fetch(id: Int) {
        let publisher = repository.fetch(id: id)

        let completion: (Subscribers.Completion<APIError>) -> Void = { completion in

            switch completion {
            case .finished:
                debugPrint("bien sapo")

            case let .failure(error):
                debugPrint("error sapo", error.description)
            }
        }

        let resultHandler: (PokemonData) -> Void = { [weak self] data in
            guard let self else { return }

            self.pokemonDetail = PokemonDetailModel(pokemonData: data)
        }

        publisher
            .subscribe(on: WorkScheduler.backgroundWorkScheduler)
            .receive(on: WorkScheduler.mainScheduler)
            .sink(receiveCompletion: completion, receiveValue: resultHandler)
            .store(in: cancelable)
    }
}

