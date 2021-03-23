//
//  Weather.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}
