//
//  FavView.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 12.05.2024.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var savedViewModel : SavedViewModel
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path : $path) {
            VStack {
                List {
                    ForEach(savedViewModel.savedNews) { new in
                        Button {
                            path.append(new)
                        } label: {
                            VStack {
                                AsyncImage(url: URL(string: new.urlToImage)) { returnedImage in
                                    returnedImage
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4.5)
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(new.title)
                                        .font(.headline)
                                    Text(new.description).lineLimit(1)
                                        .fontWeight(.light)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    
                                    HStack {
                                        Text(new.captionText)
                                            .foregroundStyle(.secondary)
                                            .font(.caption)
                                            .fontWeight(.thin)
                                        
                                        Spacer()
                                        
                                        Button {
                                            savedViewModel.toggleBookmark(for: new)
                                        } label: {
                                            Image(systemName: savedViewModel.isSaved(for: new) ? "bookmark.fill" : "bookmark")
                                            
                                        }
                                        .buttonStyle(.bordered)
                                        .clipShape(Circle())
                                        Button{
                                            savedViewModel.shareNew(new: new)
                                        } label: {
                                            Image(systemName: "square.and.arrow.up")
                                        }.buttonStyle(.bordered)
                                            .clipShape(Circle())
                                    }.padding(.top,5)
                                }.padding(.horizontal)
                            }
                            
                        }.navigationDestination(for: New.self) { new in
                            NewView(new: new)
                        }
                        .listRowSeparator(.hidden)
                    }
                }.listStyle(.plain)
                
                
                Spacer()
            }.navigationTitle("Saved News")
        }
    }
    func shareNew(new : New) {
        let activityViewController = UIActivityViewController(activityItems: [new.title, new.url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    private func toggleBookmark(for new : New) {
        if savedViewModel.isSaved(for: new) {
            savedViewModel.removeNew(for: new)
        }else {
            savedViewModel.saveNew(for: new)
        }
    }
}

#Preview {
    SavedView()
        .environmentObject(SavedViewModel())
}
