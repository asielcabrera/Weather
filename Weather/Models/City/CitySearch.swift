//
//  CitySearch.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/22/21.
//

import SwiftUI


struct CitySearch: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat, lon: Double
    let url: String
}
