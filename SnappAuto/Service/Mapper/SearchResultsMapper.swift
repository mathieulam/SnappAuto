//
//  SearchResultsMapper.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import Foundation

protocol SearchResultMapperProtocol {
    func map(_ responses: [SearchResultResponse]) -> [SearchResult]
}

struct SearchResultMapper: SearchResultMapperProtocol {
    
    func map(_ responses: [SearchResultResponse]) -> [SearchResult] {
        responses.map(map)
    }
}

// MARK: - Private

extension SearchResultMapper {
    func map(_ response: SearchResultResponse) -> SearchResult {
        SearchResult(
            flags: map(response.flags),
            priceInformation: map(response.priceInformation),
            ci: response.ci,
            distance: response.distance,
            car: map(response.car),
            user: map(response.user),
            badges: response.badges?.compactMap(map) ?? []
        )
    }
    
    func map(_ response: FlagsResponse?) -> Flags? {
        guard let response else { return nil }
        
        return Flags(
            isFavorite: response.favorite,
            isNew: response.new,
            isInstantBookable: response.instantBookable,
            isKeyless: response.isKeyless,
            wasPreviouslyRented: response.previouslyRented,
            shouldShowDurationDiscount: response.showDurationDiscount
        )
    }
    
    func map(_ response: PriceInformationResponse?) -> PriceInformation? {
        guard let response else { return nil }
        
        return PriceInformation(
            price: response.price,
            pricePerKilometer: response.pricePerKilometer,
            freeKilometersPerDay: response.freeKilometersPerDay,
            rentalDays: response.rentalDays,
            isoCurrencyCode: response.isoCurrencyCode
        )
    }
    
    func map(_ response: CarResponse?) -> Car? {
        guard let response else { return nil }
        
        return Car(
            ownerId: response.ownerId,
            year: response.year,
            fuelType: response.fuelType,
            seats: response.seats,
            model: response.model,
            make: response.make,
            createdAt: response.createdAt,
            gear: response.gear,
            bodyType: response.bodyType,
            carCategory: response.carCategory,
            reviewCount: response.reviewCount,
            reviewAvg: response.reviewAvg,
            allowed: response.allowed ?? [],
            accessories: response.accessories ?? [],
            images: response.images ?? [],
            address: map(response.address)
        )
    }
    
    func map(_ response: AddressResponse?) -> Address? {
        guard let response else { return nil }
        
        return Address(
            city: response.city,
            street: response.street,
            countryCode: response.countryCode
        )
    }
    
    func map(_ response: UserResponse?) -> User? {
        guard let response else { return nil }
        
        return User(
            firstName: response.firstName,
            imageUrl: response.imageUrl,
            street: response.street,
            city: response.city
        )
    }
    
    func map(_ response: BadgeResponse?) -> Badge? {
        guard let response else { return nil }
        
        return Badge(
            title: response.title,
            iconUrl: response.iconUrl
        )
    }
}
