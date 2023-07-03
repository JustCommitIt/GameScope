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
    private var popularGames: GameListDTO?
    private var latestGames: GameListDTO?

    // MARK: - LifeCycle

    // MARK: - Public
    func dispatchPopGames() -> GameListDTO? {
        if popularGames == nil {
            popularGames = fetchGameList(of: .popGames)
        }
        return popularGames
    }

    func dispatchLatestGames() -> GameListDTO? {
        if latestGames == nil {
            latestGames = fetchGameList(of: .latestGames)
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

