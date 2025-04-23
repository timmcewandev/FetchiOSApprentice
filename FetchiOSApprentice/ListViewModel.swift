//
//  ListViewModel.swift
//  FetchiOSApprentice
//
//  Created by Tim McEwan on 4/23/25.
//

import Foundation

@MainActor
class ListViewModel: ObservableObject {
    @Published var recipeList: [RecipeResponse] = []
    
    
}
