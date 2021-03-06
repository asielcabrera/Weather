//
//  Forecastday.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}
