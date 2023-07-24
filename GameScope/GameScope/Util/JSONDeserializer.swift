//
//  JSONDeserializer.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/07/03.
//

import Foundation

final class JSONDesirializer {

    // MARK: - Properties

    private let decoder = JSONDecoder()

    // MARK: - Public

    func deserialize(type: Decodable.Type, data: Data) throws -> Decodable {
        try decoder.decode(type.self, from: data)
    }

}
