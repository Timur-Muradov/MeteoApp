//
//  JSON.swift
//  MeteoApp
//
//  Created by Тимур Мурадов on 04.08.2022.
//

import Foundation


struct Coordinate: Codable {
    var hourly: Hourly
    var hourly_units: HourlyUnits
    var latitude: Double?
    var longitude: Double?
    var elevation: Double?
}


struct HourlyUnits: Codable { 
    var temperature_2m: String?
    var rain: String?
    var windspeed_10m: String?
}

struct Hourly: Codable {
    
    var time: [String]? 
    var temperature_2m: [Double]?
    var rain: [Double]?
    var windspeed_10m: [Double]?
    
}

