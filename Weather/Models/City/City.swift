//
//  HomeView.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

class City: Identifiable, Decodable {
    
    var id = UUID().uuidString
    
    var name: String
    var weather: Weather?
    
    init(name: String, weather: Weather?) {
        self.name = name
        self.weather = weather
        
    }
    
}
