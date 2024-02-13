import Combine
import Foundation

final class PokemonDetailViewModel: DefaultViewModel {

    private let repository: PokemonDetailRepositoryProtocol

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

        callWithProgress(argument: publiser) { [weak self] data in
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

