//
//  RecipeViewCell.swift
//  RECIME
//
//  Created by Benjamin Bartolabac on 3/27/23.
//

import Foundation
import SwiftUI
import Kingfisher

struct RecipeViewCell: View {
    
    var recipe: Recipe
    var difficulty: Diffculty = .none
        
    private let cornerRadius: CGFloat = 8
    private let imageHeight: CGFloat = 170
    private let cardHeight: CGFloat = 210
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                KFImage.url(URL(string: recipe.imageUrl))
                    .cacheMemoryOnly()
                    .fade(duration: 0.8)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: imageHeight)
                    .clipped()
                LazyVStack(alignment: .leading, spacing: 2) {
                                    Text(recipe.title)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(recipe.difficulty == difficulty ? .blue : .black)
                                    Text(recipe.difficulty.rawValue)
                                        .font(.custom("Avenir", size: 12))
                                        .foregroundColor(SwiftUI.Color.gray)
                                }
                                .padding(.horizontal,12)
                                .padding(.bottom,11)
                
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(recipe.difficulty == difficulty ? .blue : .black, lineWidth:2.0)
                    .background(SwiftUI.Color.clear)
                    .frame(height: cardHeight)
            }
        }
        .frame(height: cardHeight)
        .cornerRadius(cornerRadius)
    }
}

struct RecipeViewCell_Preview: PreviewProvider {
    static var previews: some View {
        let sampleData = Recipe(id: 1, difficulty: .easy, imageUrl: "https://ddg0cip9uom1w.cloudfront.net/code-challenge/burger.jpg", position: 1, title: "Burger")
        RecipeViewCell(recipe: sampleData)
    }
}
