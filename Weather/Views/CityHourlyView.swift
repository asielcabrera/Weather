//
//  CityHourlyView.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct CityHourlyView: View {
    var city: City
    
    private let rowHeight: CGFloat = 110
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach((city.weather?.forecast.forecastday.first!.hour)!, id: \.time) { hour in
                    VStack(spacing: 16) {
                        Text(toDate(data: hour.time))
                            .font(.footnote)
                        Text(hour.tempC.formattedTemperature)
                            .font(.headline)
                    }
                }
            }
            .padding([.trailing, .leading])
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding([.top, .bottom])
    }
    func toDate(data: String) -> String {
        return data.components(separatedBy: " ")[1]
    }
}

