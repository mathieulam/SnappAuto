//
//  SearchResultsResponse.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import Foundation

struct SearchServiceResponse: Codable {
    let results: [SearchResultResponse]
}

struct SearchResultResponse: Codable {
    let flags: FlagsResponse?
    let priceInformation: PriceInformationResponse?
    let ci: String?
    let distance: Double?
    let car: CarResponse?
    let user: UserResponse?
    let badges: [BadgeResponse]?
}

struct FlagsResponse: Codable {
    let favorite: Bool?
    let new: Bool?
    let instantBookable: Bool?
    let isKeyless: Bool?
    let previouslyRented: Bool?
    let showDurationDiscount: Bool?
}

struct PriceInformationResponse: Codable {
    let price: Double?
    let pricePerKilometer: Double?
    let freeKilometersPerDay: Int?
    let rentalDays: Int?
    let isoCurrencyCode: String?
}

struct CarResponse: Codable {
    let ownerId: String?
    let year: Int?
    let fuelType: String?
    let seats: Int?
    let model: String?
    let make: String?
    let createdAt: String?
    let gear: String?
    let bodyType: String?
    let carCategory: String?
    let reviewCount: Int?
    let reviewAvg: Double?
    let allowed: [String]?
    let accessories: [String]?
    let images: [URL]?
    let address: AddressResponse?
}

struct AddressResponse: Codable {
    let city: String?
    let street: String?
    let countryCode: String?
}

struct UserResponse: Codable {
    let firstName: String?
    let imageUrl: String?
    let street: String?
    let city: String?
}

struct BadgeResponse: Codable {
    let title: String?
    let iconUrl: URL?
}
