//
//  GameList.swift
//  GameScope
//
//  Created by 박재우 on 2023/06/30.
//

import UIKit

typealias GameList = [Game]

struct Game: Equatable, Hashable {

    let identifier: UUID = UUID()
    let id: Int
    let title: String
    var thumbnail: UIImage?
    let shortDescription: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.identifier == rhs.identifier
    }

}
