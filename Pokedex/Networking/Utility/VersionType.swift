//
//  VersionType.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import Foundation

enum VersionType {
    case none
    case v1, v2, v3
    var desc: String {
        switch self {
        case .none:
            return .empty
        case .v1:
            return "/v1"
        case .v2:
            return "/v2"
        case .v3:
            return "/v3"
        }
    }
}
