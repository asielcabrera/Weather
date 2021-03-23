//
//  CityRow.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct CityRow: View {
    
    let city: City

    var body: some View {
        NavigationLink(destination: CityWeatherView(city: city)) {
            HStack(alignment: .firstTextBaseline) {
                Text(city.name)
                    .lineLimit(nil)
                    .font(.title)
                Spacer()
                HStack {
                    Text(city.weather?.current.feelslikeC.formattedTemperature ?? "-ºC")
                        .foregroundColor(.gray)
                        .font(.title)
                }
            }
            .padding([.trailing, .top, .bottom])
        }
    }
}

