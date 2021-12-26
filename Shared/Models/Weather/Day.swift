//
//  Day.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 12/24/21.
//

import Foundation

struct Day: Codable {
    let maxtempC: Double
    let maxtempF: Double
    let mintempC, mintempF, avgtempC, avgtempF: Double
    let avghumidity, dailyWillItRain: Double
    let dailyChanceOfRain: String
    let dailyWillItSnow: Double
    let dailyChanceOfSnow: String
    let condition: Condition
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}
