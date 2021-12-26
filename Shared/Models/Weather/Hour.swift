//
//  Hour.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 12/24/21.
//

import Foundation

struct Hour: Codable {
    let timeEpoch: Double
    let time: String
    let tempC, tempF: Double
    let isDay: Double
    let condition: Condition
    let pressureMB: Double
    let pressureIn: Double
    let precipMm, precipIn, humidity, cloud: Double
    let feelslikeC, feelslikeF: Double

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
    }
}
