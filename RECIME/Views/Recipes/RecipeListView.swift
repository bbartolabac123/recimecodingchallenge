//
//  RecipeListView.swift
//  RECIME
//
//  Created by Benjamin Bartolabac on 3/27/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var viewModel: RecipeListViewModel = RecipeListViewModel()
    @State private var showingOptions = false
    
    var columns: [GridItem] = [
         GridItem(.flexible(minimum: 140)),
         GridItem(.flexible(minimum: 140))
     ]
    
    var body: some View {
        NavigationView {
            VStack(){
                Divider()
                if case .loading = viewModel.recipes {
                    SpinnerView()
                }else if case .success(let recipes) = viewModel.recipes {
                    VStack(alignment: .leading) {
                        Text("Trending Recipes")
                            .font(.custom("Avenir", size: 25))
                            .fontWeight(.bold)
                            .gridColumnAlignment(.leading)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(recipes, id: \.self) { item in
                                    RecipeViewCell(recipe: item, difficulty: viewModel.filter)
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 2, trailing: 10))
                        }
                    }
                }else if case .error(let message) = viewModel.recipes {
                    VStack(alignment: .center) {
                        Spacer()
                        Text(message)
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                }else{
                    VStack(alignment: .center) {
                        Spacer()
                        Text("No Data")
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                }
                
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Filter") {
                        showingOptions = true
                    }
                    .actionSheet(isPresented: $showingOptions) {
                        ActionSheet(
                            title: Text("Difficulty!"),
                            message: Text("You have made a selection"),
                            buttons: [
                                .cancel() {
                                    viewModel.filterRecipes(difficulty: .none)
                                },
                                .default(Text("Easy")) {
                                    viewModel.filterRecipes(difficulty: .easy)
                                },
                                .default(Text("Medium")) {
                                    viewModel.filterRecipes(difficulty: .medium)
                                },
                                .default(Text("Hard")) {
                                    viewModel.filterRecipes(difficulty: .hard)
                                }
                            ]
                        )
                    }
                }
            }
        }
        .task {
            viewModel.getRecipes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
