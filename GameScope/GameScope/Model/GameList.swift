//
//  GameList.swift
//  GameScope
//
//  Created by 박재우 on 2023/06/30.
//

import Foundation

typealias GameList = [Game]

struct Game: Equatable, Hashable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
}
