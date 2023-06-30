//
//  MinimumSystemRequirementsDTO.swift
//  GameScope
//
//  Created by 박재우 on 2023/06/30.
//

import Foundation

struct MinimumSystemRequirementsDTO: Decodable {
    let os: String
    let processor: String
    let memory: String
    let graphics: String
    let storage: String

    enum CodingKeys: CodingKey {
        case os
        case processor
        case memory
        case graphics
        case storage
    }
}

extension MinimumSystemRequirementsDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        os = try container.decode(String.self, forKey: .os)
        processor = try container.decode(String.self, forKey: .processor)
        memory = try container.decode(String.self, forKey: .memory)
        graphics = try container.decode(String.self, forKey: .graphics)
        storage = try container.decode(String.self, forKey: .storage)
    }
}
