//
//  GameListDTOTests.swift
//  GameScopeTests
//
//  Created by 박재우 on 2023/06/30.
//

import XCTest

final class GameListDTOTests: XCTestCase {

    func test_로컬_json파일의_주소를_URL로_가져오는지_확인() {
        let pathURL = Bundle.main.url(forResource: "popular-pvp-games", withExtension: "json")
        XCTAssertNotNil(pathURL, "로컬 파일을 URL로 변환하는데 실패했습니다")
    }

    func test_json파일을_Data로_인코딩_되는지_확인() {
        guard let pathURL = Bundle.main.url(forResource: "popular-pvp-games", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        let data = try? String(contentsOf: pathURL).data(using: .utf8)
        XCTAssertNotNil(data, "Data 형태로 변환에 실패했습니다")
    }

    func test_Data를_GameListDTO로_디코딩_되는지_확인() {
        guard let pathURL = Bundle.main.url(forResource: "popular-pvp-games", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        do {
            guard let data = try String(contentsOf: pathURL).data(using: .utf8) else {
                XCTFail("Data 형태로 변환에 실패했습니다")
                return
            }
            let _ = try JSONDecoder().decode(GameListDTO.self, from: data)
        } catch {
            XCTFail("GameListDTO로 디코딩에 실패했습니다")
        }
    }

    func test_GameListDTO에서_GameList로_변환되는지_함수_convert_확인() {
        guard let pathURL = Bundle.main.url(forResource: "popular-pvp-games", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        do {
            guard let data = try String(contentsOf: pathURL).data(using: .utf8) else {
                XCTFail("Data 형태로 변환에 실패했습니다")
                return
            }
            let gameListDTO = try JSONDecoder().decode(GameListDTO.self, from: data)
            let gameList = gameListDTO.map { $0.convert() }
            let result = gameList.first
            let expected = Game(id: 516,
                                title: "PUBG: BATTLEGROUNDS",
                                thumbnail: "https://www.freetogame.com/g/516/thumbnail.jpg",
                                shortDescription: "Get into the action in one of the longest running battle royale games PUBG Battlegrounds.")
            XCTAssertEqual(result, expected)
        } catch {
            XCTFail("GameListDTO로 디코딩에 실패했습니다")
        }
    }

    func test_잘못된_Data를_GameListDTO로_디코딩_실패하는지_확인() {
        let bundle = Bundle(for: type(of: self))
        guard let pathURL = bundle.url(forResource: "wrong-pvp-games", withExtension: "json") else {
            XCTFail("로컬 파일을 URL로 변환하는데 실패했습니다")
            return
        }

        do {
            guard let data = try String(contentsOf: pathURL).data(using: .utf8) else {
                XCTFail("Data 형태로 변환에 실패했습니다")
                return
            }
            let _ = try JSONDecoder().decode(GameListDTO.self, from: data)
            XCTFail("GameListDTO로 디코딩에 성공하면 안됩니다")
        } catch {
            print("id가 없다면 성공적으로 실패하였습니다")
            print(error)
        }
    }
}
