//
//  ScreenshotDTO.swift
//  GameScope
//
//  Created by 박재우 on 2023/06/30.
//

import Foundation

struct ScreenshotDTO: Codable {
    let id: Int
    let image: String

    enum CodingKeys: CodingKey {
        case id
        case image
    }
}

extension ScreenshotDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        image = try container.decode(String.self, forKey: .image)
    }
}
