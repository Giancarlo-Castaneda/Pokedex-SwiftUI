//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 12/02/24.
//

import SwiftUI

struct PokemonDetailView: View {

    private let id: Int

    @StateObject var detailViewModel: PokemonDetailViewModel = .init()

    init(id: Int) {
        self.id = id
    }

    var body: some View {
        ScrollView {
            VStack {
                if let image = detailViewModel.pokemonDetail.image {
                    ZStack(alignment: .centerLastTextBaseline) {
                        Image(.pokemonBg)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0.3)
                        ImageView(withURL: image)
                        HStack {
                            Spacer()
                            Image(systemName: "play.circle")
                                .resizable()
                                .foregroundStyle(Color.mint)
                                .frame(width: 60.0, height: 60.0)
                        }
                        .padding(.trailing)
                    }
                    .frame(maxHeight: 300)
                }

                HStack {
                    Text(detailViewModel.pokemonDetail.name)
                        .font(.largeTitle)
                    Text(detailViewModel.pokemonDetail.pokedexNumber)
                        .foregroundStyle(Color.gray)
                        .font(.largeTitle)
                }

                VStack {
                    Text("TYPE")
                        .font(.title)
                        .foregroundStyle(Color.black)
                        .padding(.top, 10)
                    HStack {
                        Spacer()
                        ForEach(detailViewModel.pokemonDetail.types, id: \.id) { element in
                            ChipView(titleKey: element.name, textColor: element.nameColor, colors: element.color)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 20)

                    Text("DATA")
                        .font(.title)
                        .padding(.top, 10)
                        .foregroundStyle(Color.black)
                    HStack {
                        Text(detailViewModel.pokemonDetail.weight)
                            .font(.body)
                            .foregroundStyle(Color.black)
                        Spacer()
                        Text(detailViewModel.pokemonDetail.height)
                            .font(.body)
                            .foregroundStyle(Color.black)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)

                    BarChartView(data: detailViewModel.pokemonDetail.chartData)
                        .padding(.horizontal, 15)

                    Text("INGAME_PREVIEW")
                        .font(.title)
                        .padding(.top, 10)
                        .foregroundStyle(Color.black)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(detailViewModel.pokemonDetail.inGameImages, id: \.id) { inGame in
                                Spacer()
                                VStack {
                                    ImageView(withURL: inGame.image)
                                        .background(
                                            RoundedRectangle(cornerRadius: 45)
                                                .fill(Color.gray.opacity(0.3))
                                        )
                                    Text(inGame.name)
                                        .lineLimit(2)
                                        .font(.title2)
                                        .foregroundStyle(Color.black)
                                }
                                .frame(height: 180)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.bottom, 50)
                }
                .roundedCorner(30, corners: [.topLeft, .topRight])
            }
            .onAppear {
                detailViewModel.fetch(id: id)
            }
        }
        .background(Color.purple.opacity(0.3))
        .scrollIndicators(.hidden)
    }
}

#Preview {
    PokemonDetailView(id: 14)
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
