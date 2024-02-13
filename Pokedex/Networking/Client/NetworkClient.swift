//
//  PokedexList.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import Foundation
import Combine

final class NetworkClient: NetworkClientProtocol {

    /// Initializes a new URL Session Client.
    ///
    /// - parameter urlSession: The URLSession to use.
    ///     Default: `URLSession(configuration: .shared)`.
    ///
    let session: URLSession
    let debugger: BaseAPIDebuger
    var subscriber = Set<AnyCancellable>()

    init(session: URLSession = .shared,
         debugger: BaseAPIDebuger = BaseAPIDebuger()) {
        self.session = session
        self.debugger = debugger
    }

    @discardableResult
    func perform<M, T>(with request: RequestBuilder,
                       decoder: JSONDecoder,
                       scheduler: T,
                       responseObject type: M.Type) -> AnyPublisher<M, APIError> where M: Decodable, T: Scheduler {

        let urlRequest = request.buildURLRequest()
        return publisher(request: urlRequest)
            .receive(on: scheduler)
            .tryMap { result, _ -> Data in
                self.debugger.log(request: urlRequest, error: nil)
                return result
            }
            .decode(type: type.self, decoder: decoder)
            .mapError { error in
                self.debugger.log(request: nil, error: error)
                return error as? APIError ?? .general
            }
            .eraseToAnyPublisher()
    }

    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), APIError> {
        return self.session.dataTaskPublisher(for: request)
            .mapError { APIError.urlError($0) }
            .map { response -> AnyPublisher<(data: Data, response: URLResponse), APIError> in
                guard let httpResponse = response.response as? HTTPURLResponse else {
                    return Fail(error: APIError.invalidResponse(httpStatusCode: 0))
                        .eraseToAnyPublisher()
                }

                if !httpResponse.isResponseOK {
                    let error = NetworkClient.errorType(type: httpResponse.statusCode)
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }

                return Just(response)
                    .setFailureType(to: APIError.self)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
