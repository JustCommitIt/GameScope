//
//  GameDetailDTO.swift
//  GameScope
//
//  Created by 박재우 on 2023/06/30.
//

import Foundation

struct GameDetailDTO: Decodable {
    let id: Int
    let title: String
    let thumbnail: String
    let status: String
    let shortDescription: String
    let description: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileURL: String
    let minimumSystemRequirements: MinimumSystemRequirementsDTO
    let screenshots: [ScreenshotDTO]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case status
        case shortDescription = "short_description"
        case description
        case gameURL = "game_url"
        case genre
        case platform
        case publisher
        case developer
        case releaseDate = "release_date"
        case freetogameProfileURL = "freetogame_profile_url"
        case minimumSystemRequirements = "minimum_system_requirements"
        case screenshots
    }
}

extension GameDetailDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        status = try container.decode(String.self, forKey: .status)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        description = try container.decode(String.self, forKey: .description)
        gameURL = try container.decode(String.self, forKey: .gameURL)
        genre = try container.decode(String.self, forKey: .genre)
        platform = try container.decode(String.self, forKey: .platform)
        publisher = try container.decode(String.self, forKey: .publisher)
        developer = try container.decode(String.self, forKey: .developer)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        freetogameProfileURL = try container.decode(String.self, forKey: .freetogameProfileURL)
        minimumSystemRequirements = try container.decode(MinimumSystemRequirementsDTO.self,
                                                         forKey: .minimumSystemRequirements)
        screenshots = try container.decode([ScreenshotDTO].self, forKey: .screenshots)
    }
}

extension GameDetailDTO {
    func convert() -> GameDetail {
        let images = screenshots.map { $0.image }

        return .init(title: title,
                     thumbnail: thumbnail,
                     description: description,
                     gameURL: gameURL,
                     genre: genre,
                     publisher: publisher,
                     developer: developer,
                     releaseDate: releaseDate,
                     screenshots: images)
    }
}
