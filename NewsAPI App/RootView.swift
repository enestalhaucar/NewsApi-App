//
//  ContentView.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 9.05.2024.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    FeedView()
                        .tabItem {
                            Label("News", systemImage: "newspaper")
                        }
                    FavView()
                        .tabItem {
                            Label("Favourites", systemImage: "suit.heart")
                        }
                }
                
            }
        }
    }
}

#Preview {
    RootView()
}
