//
//  SearchRepositoryProtocol.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import Foundation

protocol SearchRepositoryProtocol {
    func search(
        limit: Int,
        offset: Int,
        country: String,
        latitude: CGFloat,
        longitude: CGFloat,
        maximumDistance: Int,
        sort: String,
        order: String
    ) async throws -> [SearchResult]
}

struct SearchRepository: SearchRepositoryProtocol {

    private let service: SearchServiceProtocol
    private let mapper: SearchResultMapperProtocol

    init(service: SearchServiceProtocol = SearchService(), mapper: SearchResultMapperProtocol = SearchResultMapper()) {
        self.service = service
        self.mapper = mapper
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
    ) async throws -> [SearchResult] {
        let results = try await service.search(
            limit: limit,
            offset: offset,
            country: country,
            latitude: latitude,
            longitude: longitude,
            maximumDistance: maximumDistance,
            sort: sort,
            order: order
        )

        return mapper.map(results)
    }
}
