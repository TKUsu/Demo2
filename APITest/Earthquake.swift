//
//  Earthquake.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

// MARK: - Earthquake
struct Earthquake: Codable {
    let iotNextLink: String
    let value: [EarthquakeValue]
    
    enum CodingKeys: String, CodingKey {
        case iotNextLink = "@iot.nextLink"
        case value
    }
}

// MARK: - Value
struct EarthquakeValue: Codable {
    let name, valueDescription: String
    let properties: EarthquakeProperties
    let locationsIotNavigationLink, historicalLocationsIotNavigationLink, datastreamsIotNavigationLink, multiDatastreamsIotNavigationLink: String
    let iotID: Int
    let iotSelfLink: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case valueDescription = "description"
        case properties
        case locationsIotNavigationLink = "Locations@iot.navigationLink"
        case historicalLocationsIotNavigationLink = "HistoricalLocations@iot.navigationLink"
        case datastreamsIotNavigationLink = "Datastreams@iot.navigationLink"
        case multiDatastreamsIotNavigationLink = "MultiDatastreams@iot.navigationLink"
        case iotID = "@iot.id"
        case iotSelfLink = "@iot.selfLink"
    }
}

// MARK: - Properties
struct EarthquakeProperties: Codable {
    let deviceType: EarthquakeDeviceType?
    let authority: EarthquakeAuthority
    let stationName, stationID, city: String?
    let depth, magnitude: Double?
}

enum EarthquakeAuthority: String, Codable {
    case 中央氣象局 = "中央氣象局"
    case 國震中心 = "國震中心"
}

enum EarthquakeDeviceType: String, Codable {
    case fba = "FBA"
    case kinemetrics = "Kinemetrics"
    case tokyosokushin = "TOKYOSOKUSHIN"
}
