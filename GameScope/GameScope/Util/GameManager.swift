//
//  GameManager.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/07/02.
//

import Foundation

final class GameManager {

    // MARK: - Constants
    enum dummyConstants: String {
        case popGames = "popular-games"
        case latestGames = "latest-games"
    }

    // MARK: - Helper
    private let deserializer = JSONDesirializer()
    // MARK: - Properties
    private var popularGames: GameList?
    private var latestGames: GameList?

    // MARK: - LifeCycle

    // MARK: - Public
    func dispatchPopGames() -> GameList? {
        guard popularGames == nil else { return popularGames }
        guard let popularGamesDTO = fetchGameList(of: .popGames) else { return nil }

        popularGames = popularGamesDTO.map { game in
            game.convert()
        }

        return popularGames
    }

    func dispatchLatestGames() -> GameList? {
        guard latestGames == nil else { return latestGames }
        guard let popularGamesDTO = fetchGameList(of: .latestGames) else { return nil }

        latestGames = popularGamesDTO.map { game in
            game.convert()
        }
        return latestGames
    }

    // MARK: - Private
    private func fetchGameList(of listKind: dummyConstants) -> GameListDTO? {
        print(#function)
        guard let dataUrl = Bundle.main.url(
            forResource: listKind.rawValue,
            withExtension: "json") else { return nil }

        do {
            let data = try Data(contentsOf: dataUrl)
            let decodedData = try deserializer.deserialize(type: GameListDTO.self, data: data)
            guard let gameList = decodedData as? GameListDTO else { return nil }
            print("hey")
            return gameList
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }

}

