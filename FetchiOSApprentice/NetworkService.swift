//
//  NetworkService.swift
//  FetchiOSApprentice
//
//  Created by Tim McEwan on 4/25/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func getRecipeList() async throws -> [Recipe]
}

class NetworkService: NetworkServiceProtocol {
    
    func getRecipeList() async throws -> [Recipe] {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let result = try decoder.decode(RecipeResponse.self, from: data)
            return result.recipes
        } catch {
            throw  NetworkError.decodingDataError
        }
    }
    
}
