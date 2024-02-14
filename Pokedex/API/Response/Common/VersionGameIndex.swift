//
//  VersionGameIndex.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import Foundation

struct VersionGameIndex: Decodable {

    /// The internal id of an API resource within game data.
    let gameIndex: Int

    /// The version relevent to this game index.
    let version: NamedURLResource
}
