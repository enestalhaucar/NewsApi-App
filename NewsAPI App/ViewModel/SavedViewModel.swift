//
//  SavedViewModel.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 13.05.2024.
//

import Foundation
import UIKit


@MainActor
class SavedViewModel : ObservableObject {
    @Published private(set) var savedNews : [New] = []

  
    func isSaved(for new : New) -> Bool {
        savedNews.first {new.id == $0.id} != nil
    }
    
    func saveNew(for new : New) {
        guard !isSaved(for: new) else {
            return
        }
        savedNews.insert(new, at: 0)
    }
    
    func removeNew(for new : New) {
        guard let index = savedNews.firstIndex(where: {$0.id == new.id}) else {
            return
        }
        savedNews.remove(at: index)
    }
    
    func shareNew(new : New) {
        let activityViewController = UIActivityViewController(activityItems: [new.title, new.url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    func toggleBookmark(for new : New) {
        if isSaved(for: new) {
            removeNew(for: new)
        }else {
            saveNew(for: new)
        }
    }
    
    func changeDateToString(publishedAt : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let publishedAtString = dateFormatter.string(from: publishedAt)
        
        return publishedAtString
    }
}
