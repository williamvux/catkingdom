//
//  CatRepository.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import Foundation
import Combine

final class CatRepository {
    private enum UrlPaths: String {
        case catImageSearch = "/v1/images/search"
        
        var method: String {
            switch self {
                case .catImageSearch:
                    return "GET"
            }
        }
    }
    private func request(with path: UrlPaths, queries: [URLQueryItem]? = nil) -> URLRequest {
        var urlComps = URLComponents(string: "\(HttpConstant.baseUrl)\(path.rawValue)")
        
        urlComps?.queryItems = queries
        
        guard let url = urlComps?.url else {
            fatalError("Invalid URL")
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = path.method
        req.setValue(HttpConstant.apiKey, forHTTPHeaderField: HttpConstant.xApiKeyHeader)
        return req
    }
    
    func getBreeds(limit: Int, page: Int, search: String) -> URLSession.DataTaskPublisher {
        var queries: [URLQueryItem] = [
            URLQueryItem(
                name: "limit",
                value: "\(limit)"
            ),
            URLQueryItem(
                name: "has_breeds",
                value: "1"
            ),
            URLQueryItem(
                name: "order",
                value: "ASC"
            ),
            URLQueryItem(
                name: "page",
                value: "\(page)"
            )
        ]
        
        if let text = search.asNil {
            queries.append(.init(name: "breed_ids", value: text))
        }
        
        let req = request(
            with: .catImageSearch,
            queries: queries
        )
        
        return URLSession.shared.dataTaskPublisher(for: req)
    }
}
