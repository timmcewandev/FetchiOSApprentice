//
//  RecipeListView.swift
//  FetchiOSApprentice
//
//  Created by Tim McEwan on 4/23/25.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject var vm = ListViewModel()
    var body: some View {
        NavigationStack {
            if vm.isLoading {
                ProgressView()
            } else if vm.hasErrorMessage != nil {
                Text("\(vm.hasErrorMessage ?? "Oops something went wrong please check back later")")
            } else {
                List {
                    ForEach(vm.recipeList, id: \.id) { recipe in
                        ListCellView(imageURL: recipe.photoUrlSmall ??
                                     "", name: recipe.name, cuisine: recipe.cuisine)
                        .onTapGesture {
                            print("\(recipe.name)")
                        }
                    }
                }
            }
        }
        .task {
            try? await vm.getRecipeList()
        }
    }
}

#Preview {
    RecipeListView()
}
