//
//  CityDailyView.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct CityDailyView: View {
    var day: Forecastday
    
    
    var body: some View {
        HStack(alignment: .center) {
            Text(day.date)
            Spacer()
            HStack(spacing: 16) {
                verticalTemperatureView(min: true)
                verticalTemperatureView(min: false)
            }
        }
        
    }
    
    func verticalTemperatureView(min: Bool) -> some View {
        VStack {
            Text(min ? "min" : "max")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(min ? day.day.mintempC.formattedTemperature : day.day.maxtempC.formattedTemperature)
                .font(.headline)
        }
    }
    
}

