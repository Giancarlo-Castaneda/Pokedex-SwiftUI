//
//  ImageView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 9/02/24.
//

import Combine
import SwiftUI

struct ImageView: View {

    @ObservedObject var imageLoader: ImageDownloader

    init(withURL url: URL) {
        imageLoader = ImageDownloader(urlString: url.absoluteString)
    }

    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage() )
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
