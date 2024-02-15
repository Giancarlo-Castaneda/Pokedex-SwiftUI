import Combine
import Foundation
import SwiftUI

final class PokemonDetailViewModel: DefaultViewModel {

    // MARK: - Private Properties

    private let repository: PokemonDetailRepositoryProtocol

    // MARK: - Internal Properties

    @Published private(set) var pokemonDetail = PokemonDetailModel(pokemonData: .mock)
    @Published private(set) var evolutionChain: EvolutionChainModel? = nil
    @Published private(set) var isEvolutionAvailable = false
    @Published private(set) var headerColor: [Color] = []

    // MARK: - Initialization

    init(repository: PokemonDetailRepositoryProtocol = PokemonDetailRepository()) {
        self.repository = repository
    }

    // MARK: - Internal Methods

    func fetchEvolutionChain(id: Int) {
        let speciesPublisher = repository.fetchSpecies(for: id)

        callWithProgress(argument: speciesPublisher) { [weak self] data in
            guard let self else { return }
            let species = PokemonSpeciesModel(data)

            guard species.evolutionChainId != 0 else {
                return isEvolutionAvailable = false
            }

            let publisher = repository.fetchEvolution(id: species.evolutionChainId)

            callWithProgress(argument: publisher) { [weak self] data in
                guard let self else { return }

                evolutionChain = EvolutionChainModel(data)
                isEvolutionAvailable = evolutionChain?.chainType != EvolutionChainModel.ChainType.none
            }
        }
    }

    func fetch(id: Int) {
        let publisher = repository.fetch(id: id)

        callWithProgress(argument: publisher) { [weak self] data in
            guard let self else { return }

            self.pokemonDetail = PokemonDetailModel(pokemonData: data)
            self.headerColor = self.pokemonDetail.types.map { $0.color }.reduce([], +)
        }
    }
}

