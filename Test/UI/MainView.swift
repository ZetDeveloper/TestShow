//
//  ContentView.swift
//  Test
//
//  Created by Jiren on 05/08/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TvShowListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Shows")
                }
         
            Text("Favorites")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "bookmark.circle.fill")
                    Text("Favorites")
                }
         
      
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
