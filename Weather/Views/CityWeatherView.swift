//
//  CityWeatherView.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct CityWeatherView: View {
    var city: City
    
    var body: some View {
        VStack{
            Section(header: Text("Now")) {
                CityHeaderView(city: city)
            }
            
            Section(header: Text("In the day")) {
                CityHourlyView(city: city)
            }
            
            Section(header: Text("This week")) {
                
                List(city.weather!.forecast.forecastday, id: \.date) { day in
                    CityDailyView(day: day)
                    
                }
            }
        }
        .navigationBarTitle(Text(city.name))
    }
    
}
