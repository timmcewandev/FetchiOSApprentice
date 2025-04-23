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
            Text("Hello world")
        }
        .task {
            try? await vm.getRecipeList()
        }
    }
    // Set
}

#Preview {
    RecipeListView()
}
