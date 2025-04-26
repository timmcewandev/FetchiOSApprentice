//
//  ListViewModel.swift
//  FetchiOSApprentice
//
//  Created by Tim McEwan on 4/23/25.
//

import Foundation

@MainActor
class ListViewModel: ObservableObject {
    @Published var recipeList: [Recipe] = []
    @Published var isLoading: Bool = true
    @Published var hasErrorMessage: String?
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getRecipeList() async throws {
        isLoading = true

        do {
            recipeList = try await networkService.getRecipeList()
            isLoading = false
            hasErrorMessage = recipeList.isEmpty ? "Empty List" : nil
        } catch(let error) {
            isLoading = false
            hasErrorMessage = NetworkError.unknown(error).description
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case decodingDataError
    case unknown(Error)
    
    var description: String {
        switch self {
        case .invalidURL, .decodingDataError:
            "Please try again later"
        case .unknown(let error):
            error.localizedDescription
        }
    }
}
