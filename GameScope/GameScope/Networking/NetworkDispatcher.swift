//
//  NetworkDispatcher.swift
//  GameScope
//
//  Created by DONGWOOK SEO on 2023/07/06.
//

import Foundation

struct NetworkDispatcher {
    typealias NetworkResult = Result<Data, NetworkError>

    func performRequest(_ urlRequest: URLRequest?) async throws -> NetworkResult {
        let session = URLSession.shared

        guard let urlRequest else { return .failure(.invalidURL) }

        let (data, response) = try await session.data(for: urlRequest)

        if let httpResponse = response as? HTTPURLResponse {
            guard response.isValidResponse else { return .failure(.outOfResponseCode(code: httpResponse.statusCode))}
        }
        return .success(data)
    }

}
