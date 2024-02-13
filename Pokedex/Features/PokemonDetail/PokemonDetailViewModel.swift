import Combine
import Foundation

final class PokemonDetailViewModel: ObservableObject {

    private let repository: PokemonDetailRepositoryProtocol
    private let cancelable = Cancelable()

    @Published private(set) var pokemonDetail = PokemonDetailModel(pokemonData: .mock)
    @Published private(set) var evolutionChain: [PokemonEvolutionModel] = []

    init(repository: PokemonDetailRepositoryProtocol = PokemonDetailRepository()) {
        self.repository = repository
    }

    private func extractChainInfo(_ chain: Chain) -> [Chain] {
        var temp = chain.evolvesTo
        temp.append(contentsOf: chain.evolvesTo.map { extractChainInfo($0) }
            .reduce([], +))

        return temp
    }

    func fetchEvolutionChain(id: Int) {
        let publiser = repository.fetchEvolution(id: id)

        let completion: (Subscribers.Completion<APIError>) -> Void = { completion in
            switch completion {
            case .finished:
                debugPrint("bien sapo")

            case let .failure(error):
                debugPrint("error sapo", error.description)
            }
        }

        let resultHandler: (EvolutionData) -> Void = { [weak self] data in
            guard let self else { return }

            var temp = [data.chain]
            temp.append(contentsOf: extractChainInfo(data.chain))

            evolutionChain = temp.map { PokemonEvolutionModel(chainData: $0) }
        }

        publiser
            .subscribe(on: WorkScheduler.backgroundWorkScheduler)
            .receive(on: WorkScheduler.mainScheduler)
            .sink(receiveCompletion: completion, receiveValue: resultHandler)
            .store(in: cancelable)
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

