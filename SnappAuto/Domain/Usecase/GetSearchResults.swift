//
//  GetSearchResultsProtocol.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//
import Foundation

protocol GetSearchResultsProtocol {
    func execute(
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

struct GetSearchResults: GetSearchResultsProtocol {

    private let repository: SearchRepositoryProtocol

    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }

    func execute(
        limit: Int,
        offset: Int,
        country: String,
        latitude: CGFloat,
        longitude: CGFloat,
        maximumDistance: Int,
        sort: String,
        order: String
    ) async throws -> [SearchResult] {
        try await repository.search(
            limit: limit,
            offset: offset,
            country: country,
            latitude: latitude,
            longitude: longitude,
            maximumDistance: maximumDistance,
            sort: sort,
            order: order
        )
    }
}
