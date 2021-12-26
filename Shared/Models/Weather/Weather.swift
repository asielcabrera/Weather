//
//  Weather.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 12/24/21.
//

import Foundation

struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}
