//
//  DataManager.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 12.05.2024.
//

import Foundation
import SwiftyJSON
import SwiftUI

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct New : Identifiable, Hashable {
    var id : String
    let author : String
    let title : String
    let url : String
    let publishedAt : Date
    let urlToImage : String
    let description : String
    
    
    var captionText : String {
        "\(author) • \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
}

class getNews : ObservableObject {
    @Published var datas = [New]()
    
    
    func fetchNews(with keyword: String = "keyword") {
        let source = "https://newsapi.org/v2/everything?q=\(keyword)&apiKey=0a526e4a1322409d8c0c2299b1c9136b"
        
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, _ , error) in
            if error != nil {
                print(error?.localizedDescription ?? "error while getting news")
                return
            }
            let json = try! JSON(data: data!)
            
            for (_, article) in json["articles"] {
                let title = article["title"].stringValue
                let author = article["author"].stringValue
                let description = article["description"].stringValue
                let url = article["url"].stringValue
                let image = article["urlToImage"].stringValue
                let id = article["publishedAt"].stringValue
                let publishedAtString = article["publishedAt"].stringValue
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let publishedAt = dateFormatter.date(from: publishedAtString)
    
                DispatchQueue.main.async {
                    self.datas.append(New(id: id, author: author, title: title, url: url, publishedAt: publishedAt ?? Date() , urlToImage: image, description: description))
                }
            }
        }.resume()
    }
}
