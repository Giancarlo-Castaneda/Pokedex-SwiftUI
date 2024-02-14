import Combine
import Foundation

final class PokemonDetailViewModel: DefaultViewModel {

    // MARK: - Private Properties

    private let repository: PokemonDetailRepositoryProtocol

    // MARK: - Internal Properties

    @Published private(set) var pokemonDetail = PokemonDetailModel(pokemonData: .mock)
    @Published private(set) var evolutionChain: [PokemonEvolutionModel] = []

    // MARK: - Initialization

    init(repository: PokemonDetailRepositoryProtocol = PokemonDetailRepository()) {
        self.repository = repository
    }

    // MARK: - Private Methods

    private func extractChainInfo(_ chain: EvolutionChainResponse.ChainLink) -> [EvolutionChainResponse.ChainLink] {
        var temp = chain.evolvesTo
        temp.append(contentsOf: chain.evolvesTo.map { extractChainInfo($0) }
            .reduce([], +))

        return temp
    }

    // MARK: - Internal Methods

    func fetchEvolutionChain(id: Int) {
        let publisher = repository.fetchEvolution(id: id)

        callWithProgress(argument: publisher) { [weak self] data in
            guard let self else { return }

            var temp = [data.chain]
            temp.append(contentsOf: extractChainInfo(data.chain))

            evolutionChain = temp.map { PokemonEvolutionModel(chainData: $0) }
        }
    }

    func fetch(id: Int) {
        let publisher = repository.fetch(id: id)

        callWithProgress(argument: publisher) { [weak self] data in
            guard let self else { return }

            self.pokemonDetail = PokemonDetailModel(pokemonData: data)
        }
    }
}

