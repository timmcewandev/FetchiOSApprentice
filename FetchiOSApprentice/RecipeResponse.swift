//
//  RecipeResponse.swift
//  FetchiOSApprentice
//
//  Created by Tim McEwan on 4/23/25.
//

import Foundation
//{
//    "recipes": [
//        {
//            "cuisine": "Malaysian",
//            "name": "Apam Balik",
//            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
//            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
//            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
//            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
//            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
//        },
struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let uuid: String
    let name: String
    let cuisine: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    var id: String { uuid }
}


private enum CodingKeys: String, CodingKey {
    case photoUrlLarge = "photo_url_large"
    case photoUrlSmall = "photo_url_small"
    case sourceUrl = "source_url"
    case youtubeUrl = "youtube_url"
    case uuid, name, cuisine
}




