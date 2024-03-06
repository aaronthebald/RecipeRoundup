//
//  DessertRowView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI

struct DessertRowView: View {
    
    let dessert: String
    let imageData: Data?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                if let data = imageData {
                    if let image = UIImage(data: data) {
                        Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                else {
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Text(dessert)
                    .font(.title2)
                    .tint(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .tint(.primary)
            }
            Divider()
        }
    }
}

