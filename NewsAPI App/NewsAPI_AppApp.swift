//
//  NewsAPI_AppApp.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 9.05.2024.
//

import SwiftUI

@main
struct NewsAPI_AppApp: App {
    @StateObject var savedViewModel = SavedViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(SavedViewModel())
        }
    }
}
