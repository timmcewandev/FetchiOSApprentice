//
//  RecipeResponse.swift
//  FetchiOSApprentice
//
//  Created by Tim McEwan on 4/23/25.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String
    let photoUrlSmall: String
    let source_url: String
    let id: String
    let youtubeUrl: String
}

enum CodingKeys: String, CodingKey {
    case
    cuisine,
    name,
    photoUrlLarge = "photo_url_large",
    photoUrlSmall = "photo_url_small",
    id = "uuid",
    youtubeUrl = "youtube_url"
}
