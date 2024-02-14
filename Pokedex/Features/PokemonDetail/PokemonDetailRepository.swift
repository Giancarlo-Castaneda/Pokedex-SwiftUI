//
//  PokemonDetailRepository.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import Combine
import Foundation

protocol PokemonDetailRepositoryProtocol {

    func fetch(id: Int) -> AnyPublisher<PokemonDetailResponse, APIError>
    func fetchEvolution(id: Int) -> AnyPublisher<EvolutionChainResponse, APIError>
    func fetchSpecies(for id: Int) -> AnyPublisher<PokemonSpeciesResponse, APIError>
}

final class PokemonDetailRepository: NetworkClientManager<HttpRequest>, PokemonDetailRepositoryProtocol {

    func fetch(id: Int) -> AnyPublisher<PokemonDetailResponse, APIError> {
        let endpoint = HttpRequest(request: PokemonDetailRequest(id: id))

        return request(request: endpoint,
                       scheduler: WorkScheduler.mainScheduler,
                       responseObject: PokemonDetailResponse.self)
    }

    func fetchSpecies(for id: Int) -> AnyPublisher<PokemonSpeciesResponse, APIError> {
        let endpoint = HttpRequest(request: PokemonSpeciesRequest(pokemonId: id))

        return request(request: endpoint, 
                       scheduler: WorkScheduler.mainScheduler,
                       responseObject: PokemonSpeciesResponse.self)
    }

    func fetchEvolution(id: Int) -> AnyPublisher<EvolutionChainResponse, APIError> {
        let endpoint = HttpRequest(request: PokemonEvolutionRequest(id: id))

        return request(request: endpoint,
                       scheduler: WorkScheduler.mainScheduler,
                       responseObject: EvolutionChainResponse.self)
    }
}
