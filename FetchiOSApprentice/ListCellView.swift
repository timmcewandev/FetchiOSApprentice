//
//  ListCellView.swift
//  FetchiOSApprentice
//
//  Created by Tim McEwan on 4/23/25.
//

import SwiftUI

struct ListCellView: View {
    let imageURL: String
    let name: String
    let cuisine: String
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}


//#Preview {
//    ListCellView(imageURL: <#String#>, name: "Macroni", cuisine: "Chee")
//}
