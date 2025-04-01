import Combine
import Foundation

protocol GamesRepositoryProtocol {
    func fetch(offset: Int, resultLimit: Int) -> AnyPublisher<PokemonListResponse, APIError>
}

final class GamesRepository: NetworkClientManager<HttpRequest>, PokedexListRepositoryProtocol {

    func fetch(offset: Int, resultLimit: Int) -> AnyPublisher<PokemonListResponse, APIError> {
        let httpRequest = HttpRequest(request: GamesRequest(offset: offset, limit: resultLimit))

        return request(request:  httpRequest,
                       scheduler: WorkScheduler.mainScheduler,
                       responseObject: PokemonListResponse.self)
    }
}
