//
//  DataManager.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 12.05.2024.
//

import Foundation
import SwiftyJSON

struct DataType : Identifiable {
    var id : String
    var author : String
    var title : String
    var description : String
    var image : String
    var url : String
}

class getNews : ObservableObject {
    @Published var datas = [DataType]()
    init() {
        let source = "https://newsapi.org/v2/everything?q=keyword&apiKey=0a526e4a1322409d8c0c2299b1c9136b"
    
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data,_ , error) in
            if error != nil {
                print(error?.localizedDescription ?? "error while getting news")
                return
            }
            let json = try! JSON(data : data!)
            
            for i in json["articles"] {
                let title = i.1["title"].stringValue
                let author = i.1["author"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
                DispatchQueue.main.async {
                    self.datas.append(DataType(id: id, author: author, title: title, description: description, image: image, url: url))
                }
            }
        }.resume()
        
    }
}

class DataManager : ObservableObject {
    @Published var datas = [DataType]()
    func getNews(word : String) -> [DataType]{
        let source = "https://newsapi.org/v2/everything?q=keyword&apiKey=0a526e4a1322409d8c0c2299b1c9136b"
    
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data,_ , error) in
            if error != nil {
                print(error?.localizedDescription ?? "error while getting news")
                return
            }
            let json = try! JSON(data : data!)
            
            for i in json["articles"] {
                let title = i.1["title"].stringValue
                let author = i.1["author"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
                DispatchQueue.main.async {
                    self.datas.append(DataType(id: id, author: author, title: title, description: description, image: image, url: url))
                }
            }
        }.resume()
        
        return datas
    }
}
