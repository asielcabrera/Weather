//
//  WeatherManager.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import Combine
import SwiftUI

class WeatherManager {
    
    struct Key {
        
        static let weatherKey: String = "9b1c9cecda784c4ea01191152212003" // Enter your darkSky API key here
        static let baseurl = "https://api.weatherapi.com/v1/"
//        static let baseurl = "https://api.weatherapi.com/v1/current.json"
    }

    static func getWeather<T: Decodable>(for city: String, forAt day: Int) -> AnyPublisher<T, Error> {
        
        let url = URL(string: Key.baseurl + "forecast.json?key=\(Key.weatherKey)&q=\(city)&days=\(day)&aqi=no")! //&days=\(day)&aqi=no"

        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .map({ (weather) -> T in
                return weather as! T
            })
//            .print()
            .eraseToAnyPublisher()
    }
    
    static func getSearchCity(searchText: String) -> AnyPublisher<[CitySearch], Error>{
        let url = URL(string: Key.baseurl + "search.json?key=\(Key.weatherKey)&q=\(searchText)")!

        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [CitySearch].self, decoder: JSONDecoder())
//            .print()
            .eraseToAnyPublisher()

    }
}
