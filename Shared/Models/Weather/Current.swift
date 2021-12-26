//
//  Current.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 12/24/21.
//

import Foundation

struct Current: Codable {
    let lastUpdatedEpoch: Double
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph, windDegree: Double
    let windDir: String
    let pressureMB, pressureIn, precipMm, precipIn: Double
    let humidity, cloud: Double
    let feelslikeC, feelslikeF: Double
    let visKM, visMiles, uv: Double
    let gustMph, gustKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}
