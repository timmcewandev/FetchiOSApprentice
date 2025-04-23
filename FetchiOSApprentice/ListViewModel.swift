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
    
    func getRecipeList() async throws {
        let stringURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: stringURL) else { throw NetworkError.invalidURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
        // TODO: Make response and error out correctly
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let result = try decoder.decode(RecipeResponse.self, from: data)
            print("\(result.recipes.count)")
        } catch {
            throw NetworkError.decodingDataError
        }
        
    }
}

enum NetworkError: Error {
    case invalidURL
    case decodingDataError
}
