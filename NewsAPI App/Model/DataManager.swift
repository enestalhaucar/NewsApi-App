//
//  DataManager.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 12.05.2024.
//

import Foundation


fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct New : Identifiable, Hashable {
    var id : String
    let author : String
    let title : String
    let url : String
    let publishedAt : Date
    let urlToImage : String
    let description : String
    let content : String
    
    var captionText : String {
        "\(author) • \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
}


