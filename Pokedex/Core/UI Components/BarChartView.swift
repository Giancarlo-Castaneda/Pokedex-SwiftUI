//
//  BarChartView.swift
//  Pokedex
//
//  Created by Giancarlo Castañeda Garcia on 13/02/24.
//

import Charts
import SwiftUI

struct ChartData: Identifiable, Equatable {
    let type: String
    let value: Int
    var id: String { return type }
}

struct BarChartView: View {
    let data: [ChartData]

    var body: some View {
        Chart(data) { dataPoint in
            BarMark(x: .value("Population", dataPoint.value),
                    y: .value("Type", dataPoint.type))

            .foregroundStyle(by: .value("Type", dataPoint.type))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .annotation(position: .trailing, alignment: .center) {
                Text(String(dataPoint.value))
                    .font(.caption)
            }
        }
        .background(Color.clear)
        .chartLegend(.hidden)
        .chartXScale(domain: [0, 300])
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .font(.footnote)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(.trailing, 40)
    }
}

#Preview {
    BarChartView(data: [ChartData(type: "Fish", value: 110),
                        ChartData(type: "Reptils", value: 11),
                        ChartData(type: "Bird", value: 38),
                        ChartData(type: "Dog", value: 40),
                        ChartData(type: "Cat", value: 300)])
}
