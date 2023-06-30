//
//  GameDetailDTOTests.swift
//  GameScopeTests
//
//  Created by 박재우 on 2023/06/30.
//

import XCTest

final class GameDetailDTOTests: XCTestCase {

    func test_로컬_json파일의_주소를_URL로_가져오는지_확인() {
        let pathURL = Bundle.main.url(forResource: "detail-game-pubg", withExtension: "json")
        XCTAssertNotNil(pathURL, "로컬 파일을 URL로 변환하는데 실패했습니다")
    }

    func test_json파일을_Data로_인코딩_되는지_확인() {
        guard let pathURL = Bundle.main.url(forResource: "detail-game-pubg", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        let data = try? String(contentsOf: pathURL).data(using: .utf8)
        XCTAssertNotNil(data, "Data 형태로 변환에 실패했습니다")
    }

    func test_Data를_GameDetailDTO로_디코딩_되는지_확인() {
        guard let pathURL = Bundle.main.url(forResource: "detail-game-pubg", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        do {
            guard let data = try String(contentsOf: pathURL).data(using: .utf8) else {
                XCTFail("Data 형태로 변환에 실패했습니다")
                return
            }
            let _ = try JSONDecoder().decode(GameDetailDTO.self, from: data)
        } catch {
            XCTFail("GameDetailDTO로 디코딩에 실패했습니다")
        }
    }

    func test_GameDetailDTO에서_GameDetail로_변환되는지_함수_convert_확인() {
        guard let pathURL = Bundle.main.url(forResource: "detail-game-pubg", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        do {
            guard let data = try String(contentsOf: pathURL).data(using: .utf8) else {
                XCTFail("Data 형태로 변환에 실패했습니다")
                return
            }
            let gameDetailDTO = try JSONDecoder().decode(GameDetailDTO.self, from: data)
            let result = gameDetailDTO.convert()
            let expected = GameDetail(title: "PUBG: BATTLEGROUNDS",
                                      thumbnail: "https://www.freetogame.com/g/516/thumbnail.jpg",
                                      description: "Get into the action in one of the longest running battle royale games PUBG Battlegrounds. Originally titled PlayerUnknown’s Battlegrounds, the game has been offering players the full battle royale experience in a more realistic setting since 2017. Test yourself against 99 other players on seven different maps using whatever weapons you can find. Just be sure to be the last one standing, because that’s the only way to win.\r\n\r\nGo it alone or play with friends in groups of two or four. Start out with only the clothes on your back, loot buildings, towns, and other locations to obtain the equipment you need. This includes weapons, armor, vehicles, and more. If you want the really good gear – and it’s likely you do – you’ll have to take some risks and head to the more dangerous zones on the map.\r\n\r\nAs is generally the case with the battle royale formula, PUBG’s map shrinks over time, herding all players into a random location where they will eventually have no choice but to engage each other or risk taking damage outside the restricted area. At the same time, random areas of the map will be bombed. So, players must be aware of both events and do their best to avoid them.\r\n\r\nPUBG Battlegrounds is free-to-play and offers players purchasable items in the form of cosmetics. These do not impact game play.\r\n",
                                      gameURL: "https://www.freetogame.com/open/pubg",
                                      genre: "Shooter",
                                      publisher: "KRAFTON, Inc.",
                                      developer: "KRAFTON, Inc.",
                                      releaseDate: "2022-01-12",
                                      screenshots: ["https://www.freetogame.com/g/516/pubg-1.jpg",
                                                    "https://www.freetogame.com/g/516/pubg-2.jpg",
                                                    "https://www.freetogame.com/g/516/pubg-3.jpg"]
                                    )
            XCTAssertEqual(result, expected)
        } catch {
            XCTFail("GameListDTO로 디코딩에 실패했습니다")
        }
    }

    func test_잘못된_Data를_GameDetailDTO로_디코딩_실패하는지_확인() {
        let bundle = Bundle(for: type(of: self))
        guard let pathURL = bundle.url(forResource: "wrong-game-pubg", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        do {
            guard let data = try String(contentsOf: pathURL).data(using: .utf8) else {
                XCTFail("Data 형태로 변환에 실패했습니다")
                return
            }
            let _ = try JSONDecoder().decode(GameDetailDTO.self, from: data)
            XCTFail("GameDetailDTO로 디코딩에 성공하면 안됩니다")
        } catch {
            print("release_data가 없다면 성공적으로 실패하였습니다")
            print(error)
        }
    }

}
