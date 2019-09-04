//
//  Warning.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

// MARK: - Typhoon
struct Typhoon: Codable {
    let id: String
    let title: String
    let updated: Date
    let author: TyphoonAuthor
    let link: String
    let entry: [TyphoonEntry]
}
struct TyphoonAuthor: Codable {
    let name: String
}
struct TyphoonEntry: Codable {
    let id: String
    let title: String
    let updated: Date
    let author: TyphoonAuthor
    let link: TyphoonLink
    let summary: TyphoonSummary
    let category: TyphoonCategory
}
struct TyphoonCategory: Codable {
    let term: String
    
    enum CodingKeys: String, CodingKey {
        case term = "@term"
    }
}
struct TyphoonLink: Codable {
    let rel: String
    let href: String
    
    enum CodingKeys: String, CodingKey {
        case rel = "@rel"
        case href = "@href"
    }
}
struct TyphoonSummary: Codable {
    let type: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case text = "#text"
    }
}


// MARK: - EarthquakeReal
struct EarthquakeReal: Codable {
    let id: String
    let title: String
    let updated: Date
    let author: EarthquakeRealAuthor
    let link: EarthquakeRealLink
    let entry: EarthquakeRealEntry
}
struct EarthquakeRealAuthor: Codable {
    let name: String
}
struct EarthquakeRealEntry: Codable {
    let id, title: String
    let updated: Date
    let author: EarthquakeRealAuthor
    let link: EarthquakeRealLink
    let summary: EarthquakeRealSummary
    let category: EarthquakeRealCategory
}
struct EarthquakeRealCategory: Codable {
    let term: String
    
    enum CodingKeys: String, CodingKey {
        case term = "@term"
    }
}
struct EarthquakeRealLink: Codable {
    let rel: String
    let href: String
    
    enum CodingKeys: String, CodingKey {
        case rel = "@rel"
        case href = "@href"
    }
}
struct EarthquakeRealSummary: Codable {
    let type, text: String
    
    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case text = "#text"
    }
}
