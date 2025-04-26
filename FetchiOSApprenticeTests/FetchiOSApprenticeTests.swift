//
//  FetchiOSApprenticeTests.swift
//  FetchiOSApprenticeTests
//
//  Created by Tim McEwan on 4/25/25.
//

import XCTest
@testable import FetchiOSApprentice


class NetworkServiceMock: NetworkServiceProtocol {
    var willSuceed = true

    let mockRecipe = [
        Recipe(uuid: "", name: "Parmasian Chicken", cuisine: "Italy", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil),
        Recipe(uuid: "", name: "Pizza", cuisine: "Italy", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
    ]
    
    func getRecipeList() async throws -> [Recipe] {
        if willSuceed {
            return mockRecipe
        } else {
            throw NetworkError.decodingDataError
        }
    }
}

@MainActor
final class FetchiOSApprenticeTests: XCTestCase {
    var sut: ListViewModel!
    var mockNetworkService: NetworkServiceMock!
    
    
    override func setUpWithError() throws {
        mockNetworkService = NetworkServiceMock()
        sut = ListViewModel(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockNetworkService = nil
    }
    
    func testFetchRecipesSuccessfully() async throws {
        // Given
        mockNetworkService.willSuceed = true
        // When
        try? await sut.getRecipeList()
        // Then
        XCTAssertEqual(sut.recipeList.count, 2)
        XCTAssertEqual(sut.recipeList.first?.name, "Parmasian Chicken")
    }

    func testFetchFailedRecipes() async throws {
        // Given
        mockNetworkService.willSuceed = false
        // When
        try? await sut.getRecipeList()
        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.recipeList.isEmpty)
    }
}
