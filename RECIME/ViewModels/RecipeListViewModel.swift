//
//  RecipeListViewModel.swift
//  RECIME
//
//  Created by Benjamin Bartolabac on 3/27/23.
//

import Foundation
import Combine

class RecipeListViewModel: ObservableObject {
    @Published var recipes: ViewState<[Recipe]> = .loading
    @Published var filter: Diffculty = .none
    var reviewListService: ReviewListServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(reviewListService: ReviewListServiceProtocol = ReviewListServicImplementation()) {
        self.reviewListService = reviewListService
    }
    
    func getRecipes() {
        recipes = .loading
        self.reviewListService.getRecipes()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.recipes = .error(message: "Error in fetching recipes")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] recipes in
                self?.arrangeRecipes(with: recipes)
            }.store(in: &cancellables)
    }
    
    func filterRecipes(difficulty: Diffculty) {
    
        filter = difficulty
        
        if  case .success(let recipes) = recipes {
            if difficulty != .none {
                let recipes = recipes.sorted(by: {  ($0.difficulty == filter && $1.difficulty != filter) })
                self.recipes = .success(data: recipes)
            }else {
                arrangeRecipes(with: recipes)
            }
        }
    }
    
    private func arrangeRecipes(with recipe: [Recipe]) {
        let recipes: [Recipe] = recipe.sorted(by: { ($0.position < $1.position) })
        self.recipes = .success(data: recipes)
    }
    
}
