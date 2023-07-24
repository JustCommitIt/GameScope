//
//  NetworkError.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/07/06.
//

import Foundation

enum NetworkError: LocalizedError {

    case outOfResponseCode (code: Int)
    case invalidURL
    case failedRequest
    case emptyData
    case failedDecoding

    var errorDescription: String {
        switch self {
        case .outOfResponseCode(let code):
            return "Response Error (code: \(code))"
        case .failedRequest:
            return "Request Error"
        case .invalidURL:
            return "Invalided URL"
        case .emptyData:
            return "Empty Data"
        case .failedDecoding:
            return "Decoding has failed"
        }
    }

}
