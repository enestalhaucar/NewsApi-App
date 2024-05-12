//
//  FeedView.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 12.05.2024.
//

import SwiftUI

final class FeedViewModel : ObservableObject {
    @Published var datas = [DataType]()
    
    func loadNews(word : String) async throws {
        
    }
}

struct FeedView: View {
    @ObservedObject var list = getNews()
    @State private var searchWord : String = ""
    var body: some View {
        NavigationStack {
            VStack {
                
                TextField("Enter Location", text: $searchWord)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                    .padding(.horizontal, 10)
                List(list.datas) { new in
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(new.title)
                                .fontWeight(.heavy)
                            Text(new.description).lineLimit(2)
                                .fontWeight(.light)
                                .font(.caption)
                        }
                        
                        AsyncImage(url: URL(string: new.image)) { returnedImage in
                            returnedImage
                                .resizable()
                                .frame(width: 110, height: 135)
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding(.leading, 10)
                        } placeholder: {
                            ProgressView()
                        }

                    }
                }
            }.navigationTitle("News")
        }
    }
}

#Preview {
    FeedView()
}
