//
//  FeedView.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 12.05.2024.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var list = FeedViewModel()
    @EnvironmentObject var savedViewModel : SavedViewModel
    @State private var searchTerm: String = ""
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                SearchBar(text: $searchTerm) {
                    list.datas.removeAll()
                    list.fetchNews(with: searchTerm.isEmpty ? "keyword" : searchTerm)
                }
                List {
                    ForEach(0..<list.datas.count, id: \.self) { i in
                        Button {
                            path.append(list.datas[i])
                        } label: {
                            VStack {
                                AsyncImage(url: URL(string: list.datas[i].urlToImage)) { returnedImage in
                                    returnedImage
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4.5)
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
                                }.padding(.horizontal)
                            }
                        }
                        .navigationDestination(for: New.self) { new in
                            NewView(new: new)
                        }
                        .listRowSeparator(.hidden)
                        .onAppear {
                            if i == list.datas.count - 1 { // Son eleman göründüğünde
                                list.fetchNews(with: searchTerm.isEmpty ? "keyword" : searchTerm)
                            }
                        }
                    }
                    if list.isLoading {
                        ProgressView() // Haberler yüklenirken gösterilecek bir yüklenme göstergesi
                    }
                }
                .listStyle(.plain)
            }
            .padding(.vertical)
            .navigationTitle("News")
            .onAppear {
                list.fetchNews()
            }
        }
    }
}


#Preview {
    FeedView()
        .environmentObject(SavedViewModel())
}


// MARK: Search Bar View
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

