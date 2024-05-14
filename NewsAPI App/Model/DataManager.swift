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
    let content : String
    
    var captionText : String {
        "\(author) • \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
}

class getNews : ObservableObject {
    @Published var datas = [New]()
    
    
    
    @Published var isLoading: Bool = false
    private var currentPage: Int = 1
    
    
    func fetchNews(with keyword: String = "keyword") {
        guard !isLoading else { return }
        
        isLoading = true
        let source = "https://newsapi.org/v2/everything?q=\(keyword)&page=\(currentPage)&apiKey=0a526e4a1322409d8c0c2299b1c9136b"
        
        guard let url = URL(string: source) else {
            isLoading = false
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] (data, _, error) in
            guard let self = self else { return }
            self.isLoading = false
            
            if error != nil {
                print(error?.localizedDescription ?? "error while getting news")
                return
            }
            
            guard let data = data else { return }
            do {
                let json = try JSON(data: data)
                var newArticles: [New] = []
                
                for (_, article) in json["articles"] {
                    let title = article["title"].stringValue
                    let author = article["author"].stringValue
                    let description = article["description"].stringValue
                    let url = article["url"].stringValue
                    let image = article["urlToImage"].stringValue
                    let id = article["publishedAt"].stringValue
                    let publishedAtString = article["publishedAt"].stringValue
                    let content = article["content"].stringValue
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let publishedAt = dateFormatter.date(from: publishedAtString)
                    
                    let news = New(id: id, author: author, title: title, url: url, publishedAt: publishedAt ?? Date(), urlToImage: image, description: description, content: content)
                    newArticles.append(news)
                }
                
                DispatchQueue.main.async {
                    self.datas.append(contentsOf: newArticles)
                    self.currentPage += 1
                }
            } catch {
                print("JSON parse error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
