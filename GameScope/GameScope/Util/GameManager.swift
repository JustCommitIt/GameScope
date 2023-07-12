//
//  GameManager.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/07/02.
//

import UIKit

final class ImageCacheManager {

    static let shared = NSCache<NSString, UIImage>()
    private init() {}

}

final class GameManager {

    // MARK: - Constants
    enum dummyConstants: String {
        case popGames = "popular-games"
        case latestGames = "latest-games"
    }

    // MARK: - Helper
    private let deserializer = JSONDesirializer()
    private let networkDispatcher = NetworkDispatcher()

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

    func dispatchThumnail(of game: Game) async throws -> UIImage? {
        let thumbnailImageURLString = game.thumbnail
        let cacheKey = NSString(string: thumbnailImageURLString)
        if let chachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            return chachedImage
        }

        guard let thumbnailURL = URL(string: thumbnailImageURLString) else { throw NetworkError.invalidURL }
        let urlRequest = URLRequest(url: thumbnailURL)

        let imageResult = try await networkDispatcher.performRequest(urlRequest)

        switch imageResult {
        case .success(let data):
            guard let thumbnailImage = UIImage(data: data) else { throw NetworkError.emptyData}
            ImageCacheManager.shared.setObject(thumbnailImage, forKey: cacheKey)
            return thumbnailImage
        case .failure(let error):
            print(error.errorDescription)
            return nil
        }
    }

    // MARK: - Private
    private func fetchGameList(of listKind: dummyConstants) -> GameListDTO? {
        guard let dataUrl = Bundle.main.url(
            forResource: listKind.rawValue,
            withExtension: "json") else { return nil }

        do {
            let data = try Data(contentsOf: dataUrl)
            let decodedData = try deserializer.deserialize(type: GameListDTO.self, data: data)
            guard let gameList = decodedData as? GameListDTO else { return nil }
            return gameList
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }

}

