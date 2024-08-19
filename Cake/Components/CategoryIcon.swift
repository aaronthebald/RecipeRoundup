//
//  CategoryIcon.swift
//  Cake
//
//  Created by Aaron Wilson on 8/14/24.
//

import SwiftUI

struct CategoryIcon: View {
    
    @ScaledMetric private var imageSize = 75
    
    let image: Image
    let category: String
    let isSelectedTab: Bool
    
    var body: some View {
        VStack {
            image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
            Text(category)
                .font(.subheadline)
                .underline(isSelectedTab, color: .customOrange)
        }
        .frame(width: isSelectedTab ? imageSize + 10 : imageSize, height: isSelectedTab ? imageSize + 10 : imageSize)
        .padding()
        .overlay {
            Circle()
                .stroke()
        }
        .tint(isSelectedTab ? .customOrange : .black)
    }
}

#Preview {
    CategoryIcon(image: Image(.cow), category: "Beef", isSelectedTab: true)
}
