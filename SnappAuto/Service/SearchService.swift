//
//  SearchService.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import Foundation

protocol SearchServiceProtocol {
    func search(limit: Int, offset: Int, country: String, latitude: CGFloat, longitude: CGFloat, maximumDistance: Int, sort: String, order: String) async throws -> [SearchResultResponse]
}

enum SearchError: Error {
    case invalidURL
    case invalidResponse
}

enum Constants {
    static var baseUrl: String = "https://api.snappcar.nl/v2"
}


struct SearchService: SearchServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func search(
        limit: Int,
        offset: Int,
        country: String,
        latitude: CGFloat,
        longitude: CGFloat,
        maximumDistance: Int,
        sort: String,
        order: String
    ) async throws -> [SearchResultResponse] {
        guard let baseUrl = URL(string: Constants.baseUrl) else { throw SearchError.invalidURL }

        var components = URLComponents(url: baseUrl.appendingPathComponent("search/query"), resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lng", value: "\(longitude)"),
            URLQueryItem(name: "max-distance", value: "\(maximumDistance)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        guard let url = components?.url else { throw SearchError.invalidURL }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw SearchError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let searchServiceResponse = try decoder.decode(SearchServiceResponse.self, from: data)
        return searchServiceResponse.results
    }
}
