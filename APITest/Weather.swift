//
//  Meteorological.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//


import Foundation

// MARK: - Weather
struct Weather: Codable {
    let iotCount: Int
    let iotNextLink: String
    let value: [WeatherValue]
    
    enum CodingKeys: String, CodingKey {
        case iotCount = "@iot.count"
        case iotNextLink = "@iot.nextLink"
        case value
    }
}

// MARK: - Value
struct WeatherValue: Codable {
    let name, valueDescription: String
    let observationType: String
    let unitOfMeasurement: WeatherUnitOfMeasurement
    let phenomenonTime: String
    let sensorIotNavigationLink, observedPropertyIotNavigationLink, thingIotNavigationLink: String
    let thing: WeatherThing
    let observationsIotNavigationLink: String
    let observations: [WeatherObservation]
    let observationsIotNextLink: String
    let iotID: Int
    let iotSelfLink: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case valueDescription = "description"
        case observationType, unitOfMeasurement, phenomenonTime
        case sensorIotNavigationLink = "Sensor@iot.navigationLink"
        case observedPropertyIotNavigationLink = "ObservedProperty@iot.navigationLink"
        case thingIotNavigationLink = "Thing@iot.navigationLink"
        case thing = "Thing"
        case observationsIotNavigationLink = "Observations@iot.navigationLink"
        case observations = "Observations"
        case observationsIotNextLink = "Observations@iot.nextLink"
        case iotID = "@iot.id"
        case iotSelfLink = "@iot.selfLink"
    }
}

// MARK: - Observation
struct WeatherObservation: Codable {
    let phenomenonTime: String
    let resultTime: String?
    let result: Double
    let iotID: Int
    let iotSelfLink: String
    
    enum CodingKeys: String, CodingKey {
        case phenomenonTime, resultTime, result
        case iotID = "@iot.id"
        case iotSelfLink = "@iot.selfLink"
    }
}

// MARK: - Thing
struct WeatherThing: Codable {
    let name: String
    let thingDescription: String
    let properties: WeatherProperties
    let iotID: Int
    let iotSelfLink: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case thingDescription = "description"
        case properties
        case iotID = "@iot.id"
        case iotSelfLink = "@iot.selfLink"
    }
}

// MARK: - Properties
struct WeatherProperties: Codable {
    let stationID: String
    let stationName: String
    let areaDescription: String
    let citySN, townSN, attribute: String
    
    enum CodingKeys: String, CodingKey {
        case stationID, stationName, areaDescription
        case citySN = "city_SN"
        case townSN = "town_SN"
        case attribute = "Attribute"
    }
}

// MARK: - UnitOfMeasurement
struct WeatherUnitOfMeasurement: Codable {
    let name, symbol, definition: String
}
