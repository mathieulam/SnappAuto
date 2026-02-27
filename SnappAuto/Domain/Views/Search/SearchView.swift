//
//  SearchView.swift
//  SnappAuto
//
//  Created by Mathieu Lamvohee on 27/02/2026.
//

import SwiftUI

struct SearchView: View {
    
    @State var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search for a city", text: $viewModel.searchText)
                    .padding(8)
                    .padding(.leading, 28)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                                .padding(.leading, 8)
                            Spacer()
                            if !viewModel.searchText.isEmpty {
                                Button {
                                    viewModel.searchText = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.secondary)
                                }
                                .buttonStyle(.plain)
                                .padding(.trailing, 8)
                            }
                        }
                    )
                    .padding(.horizontal)
                
                List(viewModel.results, id: \.ci) { result in
                    SearchResultItemView(searchResult: result)
                }
                .listStyle(.plain)
                .overlay {
                    if viewModel.isLoading {
                        ProgressView("Searching...")
                    } else if viewModel.results.isEmpty && !viewModel.searchText.isEmpty {
                        ContentUnavailableView {
                            Label("No car found", systemImage: "car.side.and.exclamationmark")
                        } description: {
                            Text("Your upcoming check-ins will show here")
                        }
                    } else if viewModel.results.isEmpty {
                        ContentUnavailableView {
                            Label("Search for cars around you", systemImage: "magnifyingglass")
                        } description: {
                            Text("Filter search results by specific content type")
                        }
                    }
                }
                .navigationTitle("Search")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Button {
                                    viewModel.selectedSort = option
                                } label: {
                                    if viewModel.selectedSort == option {
                                        Label(option.rawValue, systemImage: "checkmark")
                                    } else {
                                        Text(option.rawValue)
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
                .alert("Error", isPresented: $viewModel.shouldShowErrorMessage, actions: {
                }, message: {
                    Text(viewModel.errorMessage)
                })
                .onChange(of: viewModel.searchText) {
                    viewModel.search()
                }
            }
            
        }
    }
}

#Preview {
    SearchView(
        viewModel: SearchViewModel(
            getSearchResults: GetSearchResults(
                repository: SearchRepository(
                    service: SearchService()
                )
            )
        )
    )
}

struct SearchResultItemView: View {
    
    let searchResult: SearchResult
    
    var body: some View {
        VStack {
            AsyncImage(url: searchResult.car?.images.first) { image in
                GeometryReader { geometry in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height
                        )
                        .clipped()
                }
                .frame(height: 200)  
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    if let bodyType = searchResult.car?.bodyType {
                        Text(bodyType.capitalized)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if let city = searchResult.car?.address?.city {
                        Text(city)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                if let price = searchResult.priceInformation?.price,
                   let currency = searchResult.priceInformation?.isoCurrencyCode {
                    Text(price, format: .currency(code: currency))
                        .font(.title2)
                        .bold()
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(.purple.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

#Preview {
    let flags = Flags(
        isFavorite: false,
        isNew: false,
        isInstantBookable: false,
        isKeyless: false,
        wasPreviouslyRented: false,
        shouldShowDurationDiscount: false
    )
    
    let priceInfo = PriceInformation(
        price: 133.88,
        pricePerKilometer: 12.20,
        freeKilometersPerDay: 100,
        rentalDays: 2,
        isoCurrencyCode: "EUR"
    )
    
    let car = Car(
        ownerId: "7da9c0cf-5837-4b99-b7ab-e0c31644b516",
        year: 1988,
        fuelType: "Petrol",
        seats: 4,
        model: "2 CV",
        make: "Citroen",
        createdAt: "2025-02-01T16:55:56.563Z",
        gear: "Manual",
        bodyType: "sedan",
        carCategory: "regular",
        reviewCount: 5,
        reviewAvg: 5,
        allowed: ["pets", "kids"],
        accessories: ["towBar"],
        images: [
            URL(string: "https://dzklgi3s0q69j.cloudfront.net/image?ii=e781cbbc-ee73-4334-e360-08dd7febbcf3")!
        ],
        address: Address(city: "Utrecht", street: "Volkerakstraat", countryCode: "NL")
    )
    
    let user = User(
        firstName: "Antoine",
        imageUrl: "https://cdn.snappcar.nl/images/7da9c0cf-5837-4b99-b7ab-e0c31644b516/2ab5ad82-c727-4148-aa15-adc233e5e40c",
        street: "Volkerakstraat",
        city: "Utrecht"
    )
    
    let searchResult = SearchResult(
        flags: flags,
        priceInformation: priceInfo,
        ci: "",
        distance: 1845.0875378517487,
        car: car,
        user: user,
        badges: []
    )
    
    SearchResultItemView(searchResult: searchResult)
}
