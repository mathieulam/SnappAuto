//
//  SearchResultMapperTests.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import XCTest
@testable import SnappAuto

final class SearchResultMapperTests: XCTestCase {

    let sut: SearchResultMapper = SearchResultMapper()

    func testMap_whenResponsesIsEmpty_shouldReturnEmptyArray() {
        // Arrange
        let responses: [SearchResultResponse] = []

        // Act
        let result = sut.map(responses)

        // Assert
        XCTAssertTrue(result.isEmpty)
    }

    func testMap_whenResponsesContainsMultipleItems_shouldReturnSameCount() {
        // Arrange
        let responses = [makeSearchResultResponse(), makeSearchResultResponse()]

        // Act
        let result = sut.map(responses)

        // Assert
        XCTAssertEqual(result.count, 2)
    }

    func testMap_whenSearchResultResponseHasAllValues_shouldMapAllFields() {
        // Arrange
        let response = makeSearchResultResponse(
            ci: "123456",
            distance: 500.0
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result.ci, "123456")
        XCTAssertEqual(result.distance, 500.0)
        XCTAssertNotNil(result.flags)
        XCTAssertNotNil(result.priceInformation)
        XCTAssertNotNil(result.car)
        XCTAssertNotNil(result.user)
    }

    func testMap_whenSearchResultResponseHasNilValues_shouldMapToNil() {
        // Arrange
        let response = SearchResultResponse(
            flags: nil,
            priceInformation: nil,
            ci: nil,
            distance: nil,
            car: nil,
            user: nil,
            badges: nil
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertNil(result.flags)
        XCTAssertNil(result.priceInformation)
        XCTAssertNil(result.ci)
        XCTAssertNil(result.distance)
        XCTAssertNil(result.car)
        XCTAssertNil(result.user)
        XCTAssertTrue(result.badges.isEmpty)
    }

    // MARK: - map(FlagsResponse?)

    func testMapFlags_whenResponseHasAllValues_shouldMapAllFields() {
        // Arrange
        let response = FlagsResponse(
            favorite: true,
            new: false,
            instantBookable: true,
            isKeyless: false,
            previouslyRented: true,
            showDurationDiscount: false
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result?.isFavorite, true)
        XCTAssertEqual(result?.isNew, false)
        XCTAssertEqual(result?.isInstantBookable, true)
        XCTAssertEqual(result?.isKeyless, false)
        XCTAssertEqual(result?.wasPreviouslyRented, true)
        XCTAssertEqual(result?.shouldShowDurationDiscount, false)
    }

    func testMapFlags_whenResponseIsNil_shouldReturnNilFlags() {
        // Arrange
        let response: FlagsResponse? = nil

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertNil(result)
    }

    func testMapPriceInformation_whenResponseHasAllValues_shouldMapAllFields() {
        // Arrange
        let response = PriceInformationResponse(
            price: 99.99,
            pricePerKilometer: 0.25,
            freeKilometersPerDay: 100,
            rentalDays: 3,
            isoCurrencyCode: "EUR"
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result?.price, 99.99)
        XCTAssertEqual(result?.pricePerKilometer, 0.25)
        XCTAssertEqual(result?.freeKilometersPerDay, 100)
        XCTAssertEqual(result?.rentalDays, 3)
        XCTAssertEqual(result?.isoCurrencyCode, "EUR")
    }

    func testMapPriceInformation_whenResponseIsNil_shouldReturnNil() {
        // Arrange
        let response: PriceInformationResponse? = nil

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertNil(result)
    }

    func testMapCar_whenResponseHasAllValues_shouldMapAllFields() {
        // Arrange
        let response = makeCarResponse(
            ownerId: "1234567",
            year: 1988,
            make: "Citroen",
            model: "2 CV"
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result?.ownerId, "1234567")
        XCTAssertEqual(result?.year, 1988)
        XCTAssertEqual(result?.make, "Citroen")
        XCTAssertEqual(result?.model, "2 CV")
        XCTAssertNotNil(result?.address)
    }

    func testMapCar_whenResponseIsNil_shouldReturnNil() {
        // Arrange
        let response: CarResponse? = nil

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertNil(result)
    }

    func testMapCar_whenArraysAreNil_shouldReturnEmptyArrays() {
        // Arrange
        let response = CarResponse(
            ownerId: nil, year: nil, fuelType: nil, seats: nil,
            model: nil, make: nil, createdAt: nil, gear: nil,
            bodyType: nil, carCategory: nil, reviewCount: nil,
            reviewAvg: nil, allowed: nil, accessories: nil,
            images: nil, address: nil
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result?.allowed, [])
        XCTAssertEqual(result?.accessories, [])
        XCTAssertEqual(result?.images, [])
    }

    func testMapAddress_whenResponseHasAllValues_shouldMapAllFields() {
        // Arrange
        let response = AddressResponse(
            city: "Utrecht",
            street: "Lange Nieuwstraat",
            countryCode: "NL"
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result?.city, "Utrecht")
        XCTAssertEqual(result?.street, "Lange Nieuwstraat")
        XCTAssertEqual(result?.countryCode, "NL")
    }

    func testMapAddress_whenResponseIsNil_shouldReturnNil() {
        // Arrange
        let response: AddressResponse? = nil

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertNil(result)
    }

    func testMapUser_whenResponseHasAllValues_shouldMapAllFields() {
        // Arrange
        let response = UserResponse(
            firstName: "Antoine",
            imageUrl: "https://snappauto.com/image.jpg",
            street: "Volkerakstraat",
            city: "Utrecht"
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result?.firstName, "Antoine")
        XCTAssertEqual(result?.imageUrl, "https://snappauto.com/image.jpg")
        XCTAssertEqual(result?.street, "Volkerakstraat")
        XCTAssertEqual(result?.city, "Utrecht")
    }

    func testMapUser_whenResponseIsNil_shouldReturnNil() {
        // Arrange
        let response: UserResponse? = nil

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertNil(result)
    }

    func testMapBadge_whenResponseHasAllValues_shouldMapAllFields() {
        // Arrange
        let response = BadgeResponse(
            title: "Super Host",
            iconUrl: URL(string: "https://snappauto.com/badge.png")
        )

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result?.title, "Super Host")
        XCTAssertEqual(result?.iconUrl, URL(string: "https://snappauto.com/badge.png"))
    }

    func testMapBadge_whenResponseIsNil_shouldReturnNil() {
        // Arrange
        let response: BadgeResponse? = nil

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertNil(result)
    }

    func testMap_whenBadgesContainsMixOfValidAndNil_shouldCompactMap() {
        // Arrange
        let badge1 = BadgeResponse(title: "Top", iconUrl: nil)
        let badge2 = BadgeResponse(title: "Pro", iconUrl: nil)
        let response = makeSearchResultResponse(badges: [badge1, badge2])

        // Act
        let result = sut.map(response)

        // Assert
        XCTAssertEqual(result.badges.count, 2)
    }
}

// MARK: - Private

private extension SearchResultMapperTests {

    func makeSearchResultResponse(
        ci: String? = "123892381019238",
        distance: Double? = 100.0,
        badges: [BadgeResponse]? = []
    ) -> SearchResultResponse {
        SearchResultResponse(
            flags: FlagsResponse(
                favorite: false, new: true, instantBookable: false,
                isKeyless: false, previouslyRented: false, showDurationDiscount: false
            ),
            priceInformation: PriceInformationResponse(
                price: 50.0, pricePerKilometer: 0.25,
                freeKilometersPerDay: 100, rentalDays: 1, isoCurrencyCode: "EUR"
            ),
            ci: ci,
            distance: distance,
            car: makeCarResponse(),
            user: UserResponse(
                firstName: "Jacob", imageUrl: "https://snappauto.com/user.jpg",
                street: "Jacob's Street", city: "Port Louis"
            ),
            badges: badges
        )
    }

    func makeCarResponse(
        ownerId: String? = "123456",
        year: Int? = 2020,
        make: String? = "Toyota",
        model: String? = "Corolla"
    ) -> CarResponse {
        CarResponse(
            ownerId: ownerId, year: year, fuelType: "Petrol", seats: 5,
            model: model, make: make, createdAt: "2025-01-01T00:00:00Z",
            gear: "Manual", bodyType: "sedan", carCategory: "regular",
            reviewCount: 3, reviewAvg: 4.5,
            allowed: ["kids"], accessories: ["GPS"],
            images: [URL(string: "https://snappauto.com/car1.jpg")!],
            address: AddressResponse(city: "Utrecht", street: "Hoverniersweg", countryCode: "NL")
        )
    }
}
