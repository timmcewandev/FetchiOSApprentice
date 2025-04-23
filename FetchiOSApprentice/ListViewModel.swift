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
    
    func getRecipeList() async throws {
        isLoading = true
        let stringURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: stringURL) else {
            isLoading = false
            hasErrorMessage = "There is something wrong 😑 \n Please come back later"
            throw NetworkError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let res = response as? HTTPURLResponse,
                  (200...299).contains(res.statusCode) else {
                throw NetworkError.decodingDataError
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let result = try decoder.decode(RecipeResponse.self, from: data)
            recipeList = result.recipes
            isLoading = false
            hasErrorMessage = nil
        } catch(let error) {
            hasErrorMessage = error.localizedDescription
            throw NetworkError.decodingDataError
        }
        
    }
}

enum NetworkError: Error {
    case invalidURL
    case decodingDataError
}
