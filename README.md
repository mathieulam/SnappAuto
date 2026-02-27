# SnappAuto

## Features

### Car Search
- Search for available rental cars by city name
- Hardcoded list of supported Dutch cities (Amsterdam, Rotterdam, Utrecht, Den Haag, Eindhoven, Groningen) with their coordinates
- City suggestions appear as the user types

### Debounced Search
- Search is triggered 500ms after the user stops typing
- If the user continues typing, the previous search is cancelled and a new one starts after another 500ms of inactivity

### Sorting
- Sort search results via a dropdown menu in the toolbar
- Available sort options: Price, Recommended, Distance

### Search Results
- Results are loaded in batches of 10
- Each result displays the car image, body type, city, and price per day
- Empty states are shown when no results are found or when the user hasn't searched yet

### Error Handling
- Errors are displayed via an alert
- Cancellation errors (from debouncing) are silently ignored

## Architecture

The project follows a Clean Architecture approach with clear separation of concerns:

```
View → ViewModel → UseCase → Repository → Service
                                  ↓
                               Mapper
```

- **View (SwiftUI)**: Renders the UI and binds to the ViewModel
- **ViewModel (`@Observable`)**: Holds UI state, handles debouncing and triggers the use case
- **UseCase**: Encapsulates a single business action (fetching search results)
- **Repository**: Coordinates between the service and the mapper
- **Service**: Handles the network request to the SnappCar API
- **Mapper**: Converts service response models (DTOs) to domain models

All layers communicate through protocols, making them easy to test and mock.

### Models
- **Response models** (e.g. `CarResponse`, `UserResponse`): Represent the raw API response, suffixed with `Response`
- **Domain models** (e.g. `Car`, `User`): Clean models used throughout the app

## Development Approach

The project was built incrementally, layer by layer, starting from the data and working up to the UI:

1. **Service layer** — Defined the API contract first: service protocol, response models, and network call to establish a solid data foundation
2. **Domain layer** — Built the repository and mapper to convert response models into clean domain models, decoupling the rest of the app from the API
3. **UI** — Created the SwiftUI views and connected them to the data layer through the ViewModel
4. **Validation** — Verified that search results were displaying correctly end-to-end
5. **Business rules** — Added debounced search, city filtering, sorting, error handling, and loading states in the ViewModel
6. **UI polish** — Improved the visual design of the search bar, result cards, and empty states
7. **Unit tests** — Wrote tests for the mapper to ensure correct data transformation between layers

## If I Had More Time

- Add pagination to load more results as the user scrolls
- Add unit tests for the ViewModel, Repository, and Service
- Improve error handling with more descriptive error types
- Support more countries beyond the Netherlands

## AI Disclosure

Unit tests for the mapper were generated with the assistance of AI.
