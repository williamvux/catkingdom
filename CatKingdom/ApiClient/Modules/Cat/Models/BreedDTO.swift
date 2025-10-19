//
//  BreedDTO.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import Foundation

struct BreedDTO: Codable {
    let weight: Weight?
    let id, name: String
    let cfaURL: String?
    let vetstreetURL: String?
    let vcahospitalsURL: String?
    let temperament, origin, countryCodes, countryCode: String?
    let description: String
    let lifeSpan, altNames: String?
    let wikipediaURL: String?
    let referenceImageID: String?
    
    enum CodingKeys: String, CodingKey {
        case weight, id, name
        case cfaURL = "cfa_url"
        case vetstreetURL = "vetstreet_url"
        case vcahospitalsURL = "vcahospitals_url"
        case temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case description
        case lifeSpan = "life_span"
        case altNames = "alt_names"
        case wikipediaURL = "wikipedia_url"
        case referenceImageID = "reference_image_id"
    }
    
    struct Weight: Codable {
        let imperial, metric: String
    }
}

struct CatWrapperDTO: Codable {
    let breeds: [BreedDTO]
    let height: Int
    let id: String
    let url: String
    let width: Int
}
