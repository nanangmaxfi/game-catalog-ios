//
//  Game.swift
//  SubsGameCatalog
//
//  Created by Nanang Makfi Mubarok on 22/08/21.
//

import UIKit

struct Games: Codable {
    let count: Int
    let nextPage: String
    let previousPage: String?
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextPage = "next"
        case previousPage = "previous"
        case games = "results"
    }
}

struct Game: Codable{
    let id: Int
    let nameGame: String
    let releaseDate: String
    let rating: Double
    let imageGame: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case nameGame = "name"
        case releaseDate = "released"
        case rating
        case imageGame = "background_image"
    }
}

struct GameDetail: Codable{
    let id: Int
    let nameGame: String
    let releaseDate: String
    let rating: Double
    let imageGame: String
    let playtime: Int
    let reviewCount: Int
    let genres: [Genre]
    let description: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case nameGame = "name"
        case releaseDate = "released"
        case rating
        case imageGame = "background_image"
        case playtime
        case reviewCount = "reviews_count"
        case genres
        case description = "description_raw"
    }
}

struct Genre: Codable{
    let id: Int
    let name: String
}

