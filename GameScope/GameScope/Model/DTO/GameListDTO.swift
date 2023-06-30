//
//  GameListDTO.swift
//  GameScope
//
//  Created by 박재우 on 2023/06/30.
//

import Foundation

typealias GameListDTO = [GameDTO]

struct GameDTO: Decodable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case shortDescription = "short_description"
        case gameURL = "game_url"
        case genre
        case platform
        case publisher
        case developer
        case releaseDate = "release_date"
        case freetogameProfileURL = "freetogame_profile_url"
    }
}

extension GameDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self , forKey: .title)
        thumbnail = try container.decode(String.self , forKey: .thumbnail)
        shortDescription = try container.decode(String.self , forKey: .shortDescription)
        gameURL = try container.decode(String.self , forKey: .gameURL)
        genre = try container.decode(String.self , forKey: .genre)
        platform = try container.decode(String.self , forKey: .platform)
        publisher = try container.decode(String.self , forKey: .publisher)
        developer = try container.decode(String.self , forKey: .developer)
        releaseDate = try container.decode(String.self , forKey: .releaseDate)
        freetogameProfileURL = try container.decode(String.self , forKey: .freetogameProfileURL)
    }
}

extension GameDTO {
    func convert() -> Game {
        return .init(id: id,
                     title: title,
                     thumbnail: thumbnail,
                     shortDescription: shortDescription)
    }
}
