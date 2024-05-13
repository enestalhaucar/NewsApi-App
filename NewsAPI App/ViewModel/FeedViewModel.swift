//
//  FeedViewModel.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 13.05.2024.
//

import Foundation
import UIKit
import SwiftUI

@MainActor
final class FeedViewModel : ObservableObject {
    @EnvironmentObject var savedViewModel : SavedViewModel
    func shareNew(new : New) {
        let activityViewController = UIActivityViewController(activityItems: [new.title, new.url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    func toggleBookmark(for new : New) {
        if savedViewModel.isSaved(for: new) {
            savedViewModel.removeNew(for: new)
        }else {
            savedViewModel.saveNew(for: new)
        }
    }
}
