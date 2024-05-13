//
//  ContentView.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 9.05.2024.
//

import SwiftUI


struct RootView: View {
    
    var body: some View {
         
            VStack {
                TabView {
                    FeedView()
                        .tabItem {
                            Label("News", systemImage: "newspaper")
                        }
                    SavedView()
                        .tabItem {
                            Label("Saved News", systemImage: "suit.heart")
                        }
                }.tint(.primary)
                    
                
            }
        
    }
}

#Preview {
    RootView()
        .environmentObject(SavedViewModel())
}
