import Foundation

struct GamesRequest: NetworkTarget {
    let offset: Int
    let limit: Int

    var baseURL: BaseURLType {
        .baseApi
    }

    var version: VersionType {
        .v2
    }

    var path: String? {
        "/pokedex"
    }

    var methodType: HTTPMethod {
        .get
    }

    var queryParams: [String : String]? {
        [
            "limit": String(limit),
            "offset": String(offset)
        ]
    }

    var queryParamsEncoding: URLEncoding? {
        .percentEncoded
    }
}
