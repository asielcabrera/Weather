//
//  weatherStore.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI
import Combine

class WeatherStore: ObservableObject {
    private var cancellable: [AnyCancellable?] = [AnyCancellable]()
    var citiesName: [String] = []
    @Published var cities: [City] = [City]()
    @Published var weather: Weather?
    
    init() {
        self.citiesName = UserDefaults.standard.object(forKey: "citiesName") as? [String] ?? [String]()
//        print(citiesName)
        getData()
    }
    
    func getData(){
        self.cities = []
        self.citiesName.forEach { cityName in
            self.cancellable.append(
                WeatherManager.getWeather(for: cityName, forAt: 4)
                    .receive(on: RunLoop.main)
                    .tryMap({ (weather: Weather) -> Weather in
                        self.cities.append(City(name: weather.location.name , weather: weather))
                        return weather
                    })
                    .catch({ _ in Just(self.weather)})
                    .assign(to: \.weather, on: self)
            )
        }
    }
}
