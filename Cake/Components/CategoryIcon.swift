//
//  CategoryIcon.swift
//  Cake
//
//  Created by Aaron Wilson on 8/14/24.
//

import SwiftUI

struct CategoryIcon: View {
    
    let image: Image
    let category: String
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
            Text(category)
                .font(.subheadline)
        }
        .frame(width: 75, height: 75)
        .padding()
        .overlay {
            Circle()
                .stroke()
        }
        
    }
}

#Preview {
    CategoryIcon(image: Image(.cow), category: "Beef")
}
