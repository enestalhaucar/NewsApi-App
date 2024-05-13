//
//  SavedViewModel.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 13.05.2024.
//

import Foundation


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
    
    
}
