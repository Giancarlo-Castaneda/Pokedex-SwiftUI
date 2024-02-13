//
//  PokedexListRequest.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 10/02/24.
//

import Foundation

struct PokedexListRequest: NetworkTarget {

    let offset: Int
    let limit: Int

    var baseURL: BaseURLType {
        .baseApi
    }

    var version: VersionType {
        .v2
    }

    var path: String? {
        "/pokemon"
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
