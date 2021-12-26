//
//  AirQuality.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 12/24/21.
//

import Foundation

struct AirQuality: Codable {
    var co: Double
    var no2: Double
    var o3:Double
    var so2: Double
    var pm25: Double
    var pm10: Double
    var usEpaIndex: Double
    var gbDefraIndex: Double
    
    enum CodingKeys: String, CodingKey {
        case co = "co"
        case no2 = "no2"
        case o3 = "o3"
        case so2 = "so2"
        case pm25 = "pm2_5"
        case pm10 = "pm10"
        case usEpaIndex = "us-epa-index"
        case gbDefraIndex = "gb-defra-index"
    }
}
