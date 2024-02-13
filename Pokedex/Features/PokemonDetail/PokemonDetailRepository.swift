//
//  PokemonDetailRepository.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import Combine
import Foundation

protocol PokemonDetailRepositoryProtocol {

    func fetch(id: Int) -> AnyPublisher<PokemonData, APIError>
    func fetchEvolution(id: Int) -> AnyPublisher<EvolutionData, APIError>
}

final class PokemonDetailRepository: NetworkClientManager<HttpRequest>, PokemonDetailRepositoryProtocol {

    func fetch(id: Int) -> AnyPublisher<PokemonData, APIError> {
        let endpoint = HttpRequest(request: PokemonDetailRequest(id: id))

        return request(request: endpoint,
                       scheduler: WorkScheduler.mainScheduler,
                       responseObject: PokemonData.self)
    }

    func fetchEvolution(id: Int) -> AnyPublisher<EvolutionData, APIError> {
        let endpoint = HttpRequest(request: PokemonEvolutionRequest(id: id))

        return request(request: endpoint, scheduler: WorkScheduler.mainScheduler, responseObject: EvolutionData.self)
    }
}
