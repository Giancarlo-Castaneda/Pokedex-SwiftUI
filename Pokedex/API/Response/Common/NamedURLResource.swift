//
//  NamedURLResource.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 14/02/24.
//

import Foundation

/// Common name & URL resource.
struct NamedURLResource: Decodable, Hashable {

    let name: String

    let url: URL?
}
