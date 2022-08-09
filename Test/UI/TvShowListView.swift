//
//  ShowListView.swift
//  Test
//
//  Created by Jiren on 05/08/22.
//

import SwiftUI

struct TvShowListView: View {
    @StateObject var viewModel = TvShowListViewModel()
    
    init() {
        let backgroundColor = UIColor.purple
        let titleColor = UIColor.white
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isloading) {
            NavigationView {
                List {
                    ForEach(viewModel.array) { i in
                        HStack(spacing: 8) {
                            if let url = URL(string: i.poster) {
                                AsyncImage(url: url){ image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                            }
                            
                            Text("\(i.name)")
                        }
                        
                        .padding(.vertical, 10)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                viewModel.delete(id: i.id)
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                            if !i.isFavorite {
                                Button {
                                    viewModel.favorite(id: i.id)
                                } label: {
                                    
                                    Text("Favorite")
                                }
                                .tint(.green)
                            }
                            
                        }
                    }
                }
                .listStyle(InsetListStyle())
                .navigationTitle("Tv Shows")
            }
        }
        .onAppear {
            viewModel.getTvShowList()
        }
    }
}

struct ShowListView_Previews: PreviewProvider {
    static var previews: some View {
        TvShowListView()
    }
}
