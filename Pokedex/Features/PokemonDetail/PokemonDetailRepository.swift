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
}

final class PokemonDetailRepository: NetworkClientManager<HttpRequest>, PokemonDetailRepositoryProtocol {

    func fetch(id: Int) -> AnyPublisher<PokemonData, APIError> {
        let endpoint = HttpRequest(request: PokemonDetailRequest(id: id))

        return request(request: endpoint,
                       scheduler: WorkScheduler.mainScheduler,
                       responseObject: PokemonData.self)
    }
}
