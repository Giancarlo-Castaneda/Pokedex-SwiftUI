//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import Foundation

struct PokemonListResponse: Decodable {

    /// The total number of resources available from this API.
    let count: Int

    /// The URL for the next page in the list.
    let next: URL?

    /// The URL for the previous page in the list.
    let previous: URL?

    /// A list of named API resources.
    let results: [NamedURLResource]
}
