//
//  FeedView.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 12.05.2024.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var list = getNews()
    @EnvironmentObject var savedViewModel : SavedViewModel
    @State private var searchTerm = ""
    
    var body: some View {
        ZStack {
            
            NavigationStack {
                
                VStack {
                    SearchBar(text: $searchTerm) {
                        list.datas.removeAll()
                        list.fetchNews(with: searchTerm.isEmpty ? "keyword" : searchTerm)
                    }
                    
                    List {
                        ForEach(0..<list.datas.count, id: \.self) { i in
                            
                            NavigationLink(value: list.datas[i]) {
                                VStack {
                                    AsyncImage(url: URL(string: list.datas[i].urlToImage)) { returnedImage in
                                        returnedImage
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(list.datas[i].title)
                                            .font(.headline)
                                        Text(list.datas[i].description).lineLimit(1)
                                            .fontWeight(.light)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        
                                        HStack {
                                            Text(list.datas[i].captionText)
                                                .foregroundStyle(.secondary)
                                                .font(.caption)
                                                .fontWeight(.thin)
                                            
                                            Spacer()
                                            
                                            Button {
                                                savedViewModel.toggleBookmark(for: list.datas[i])
                                            } label: {
                                                Image(systemName: savedViewModel.isSaved(for: list.datas[i]) ? "bookmark.fill" : "bookmark")
                                                
                                            }
                                            .buttonStyle(.bordered)
                                            .clipShape(Circle())
                                            Button{
                                                savedViewModel.shareNew(new: list.datas[i])
                                            } label: {
                                                Image(systemName: "square.and.arrow.up")
                                            }.buttonStyle(.bordered)
                                                .clipShape(Circle())
                                        }.padding(.top,5)
                                    }
                                    
                                    
                                    
                                }
                            }
                            .padding(.bottom, 15)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .listRowSeparator(.hidden)
                            
                        }
                        
                        
                        
                    }
                    .listStyle(.plain)
                    .navigationDestination(for: New.self) { new in
                        NewView(new: new)
                    }
                    
                }
                .padding(.vertical)
                .navigationTitle("News")
                .onAppear {
                    list.fetchNews()
                }
                
                
                
                
            }
        }
    }
    
    
}

#Preview {
    
    FeedView()
        .environmentObject(SavedViewModel())
    
}

struct SearchBar: View {
    @Binding var text: String
    var onSearchButtonClicked: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                onSearchButtonClicked()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding(8)
        }
        .padding(.horizontal)
        .padding(.bottom, 12)
    }
}

