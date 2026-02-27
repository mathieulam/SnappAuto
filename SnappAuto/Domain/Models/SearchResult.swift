//
//  SearchResult.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import Foundation

struct SearchResult: Codable {
    let flags: Flags?
    let priceInformation: PriceInformation?
    let ci: String?
    let distance: Double?
    let car: Car?
    let user: User?
    let badges: [Badge]
}

struct Flags: Codable {
    let isFavorite: Bool?
    let isNew: Bool?
    let isInstantBookable: Bool?
    let isKeyless: Bool?
    let wasPreviouslyRented: Bool?
    let shouldShowDurationDiscount: Bool?
}

struct PriceInformation: Codable {
    let price: Double?
    let pricePerKilometer: Double?
    let freeKilometersPerDay: Int?
    let rentalDays: Int?
    let isoCurrencyCode: String?
}

struct Car: Codable {
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
    let allowed: [String]
    let accessories: [String]
    let images: [URL]
    let address: Address?
}

struct Address: Codable {
    let city: String?
    let street: String?
    let countryCode: String?
}

struct User: Codable {
    let firstName: String?
    let imageUrl: String?
    let street: String?
    let city: String?
}

struct Badge: Codable {
    let title: String?
    let iconUrl: URL?
}
