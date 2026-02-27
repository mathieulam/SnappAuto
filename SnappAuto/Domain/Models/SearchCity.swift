//
//  SearchCity.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import Foundation

struct SearchCity {
    let name: String
    let country: String
    let latitude: CGFloat
    let longitude: CGFloat
}

extension SearchCity {
    static let all: [SearchCity] = [
        SearchCity(name: "Amsterdam", country: "NL", latitude: 52.3676, longitude: 4.9041),
        SearchCity(name: "Rotterdam", country: "NL", latitude: 51.9225, longitude: 4.4792),
        SearchCity(name: "Utrecht", country: "NL", latitude: 52.0907, longitude: 5.1214),
        SearchCity(name: "Den Haag", country: "NL", latitude: 52.0705, longitude: 4.3007),
        SearchCity(name: "Eindhoven", country: "NL", latitude: 51.4416, longitude: 5.4697),
        SearchCity(name: "Groningen", country: "NL", latitude: 53.2194, longitude: 6.5665)
    ]

    static func matching(_ query: String) -> [SearchCity] {
        if query.isEmpty { return all }
        return all.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
