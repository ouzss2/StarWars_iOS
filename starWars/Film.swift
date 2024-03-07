//
//  film.swift
//  starWars
//
//  Created by Tekup-mac-1 on 3/2/2024.
//

import Foundation

struct Film: Codable {
    let title: String
    let release_date: String // Adjusted property name to match the key in the JSON response
    let director: String
    let producer: String
    let opening_crawl: String // Adjusted property name to match the key in the JSON response
    let created: String
    let edited: String

    // Add CodingKeys enum to handle custom key mappings if needed
    enum CodingKeys: String, CodingKey {
        case title
        case release_date // Map to "release_date" in the JSON response
        case director
        case producer
        case opening_crawl // Map to "opening_crawl" in the JSON response
        case created
        case edited
    }
}
