//
//  SearchViewModel.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import Foundation
import SwiftUI

enum SortOption: String, CaseIterable {
    case price = "Price"
    case recommended = "Recommended"
    case distance = "Distance"
}

@Observable
class SearchViewModel {
    
    var searchText: String = ""
    var results: [SearchResult] = []
    var selectedSort: SortOption = .recommended {
        didSet { search() }
    }
    var shouldShowErrorMessage: Bool = false
    var errorMessage: String = ""
    var isLoading: Bool = false

    private var searchTask: Task<Void, Never>?
    private var matchingCities: [SearchCity] { SearchCity.matching(searchText) }
    private let getSearchResults: GetSearchResultsProtocol
    
    init(getSearchResults: GetSearchResultsProtocol = GetSearchResults()) {
        self.getSearchResults = getSearchResults
    }
    
    func search() {
        searchTask?.cancel()
        searchTask = Task {
            do {
                errorMessage = ""
                shouldShowErrorMessage = false
                
                try await Task.sleep(for: .seconds(0.5))
                guard let city = matchingCities.first else { return }
                if searchText.isEmpty {
                    results = []
                    return
                }
                isLoading = true
                await fetch(
                    country: city.country,
                    latitude: city.latitude,
                    longitude: city.longitude,
                    sort: selectedSort.rawValue
                )
                isLoading = false
            } catch is CancellationError {
                
            } catch {
                isLoading = false
                errorMessage = "Something went wrong, please try again"
                shouldShowErrorMessage = true
            }
        }
    }
}

// MARK: - Private

private extension SearchViewModel {
    func fetch(
        limit: Int = 10,
        offset: Int = 0,
        country: String = "NL",
        latitude: CGFloat = 52.0907,
        longitude: CGFloat = 5.1214,
        maximumDistance: Int = 3000,
        sort: String = "price",
        order: String = "asc"
    ) async {
        do {
            results = try await getSearchResults.execute(
                limit: limit,
                offset: offset,
                country: country,
                latitude: latitude,
                longitude: longitude,
                maximumDistance: maximumDistance,
                sort: sort,
                order: order
            )
        } catch {
            print(error)
        }
    }
}
