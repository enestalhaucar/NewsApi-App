//
//  NewView.swift
//  NewsAPI App
//
//  Created by Enes Talha Uçar  on 13.05.2024.
//

import SwiftUI
import WebKit

struct NewView: View {
    @EnvironmentObject var savedViewModel : SavedViewModel
    let new : New
    
    var body: some View {
        
        VStack {
            VStack {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: new.urlToImage)) { returnedImage in
                        returnedImage
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 9.5 / 10, height: 300)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                
                
                VStack(alignment: .leading) {
                    Text(new.title)
                            .fontWeight(.heavy)
                            .font(.headline)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        
                }
                
                
                VStack(alignment: .center) {
                    HStack {
                        HStack {
                            Image(systemName: "person.fill")
                            
                            Text(new.author)
                        }
                        HStack {
                            Image(systemName: "calendar")
                            
                            Text(savedViewModel.changeDateToString(publishedAt: new.publishedAt))
                        }
                    }
                }
                
                ScrollView {
                    Text(new.description)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
            }
            
            Spacer()
            Spacer()
            Spacer()
            
            NavigationLink(value: new.url) {
                Text("News Source")
                    .frame(width: UIScreen.main.bounds.width * 7 / 10, height: 40)
                    .background(.yellow)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .padding(.vertical, 10)
            }
            
            
            
            
            
            
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    savedViewModel.toggleBookmark(for: new)
                } label: {
                    Image(systemName: savedViewModel.isSaved(for: new) ? "bookmark.fill" : "bookmark")
                }
                .buttonStyle(.bordered)
                .clipShape(Circle())
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    savedViewModel.shareNew(new: new)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .buttonStyle(.bordered)
                .clipShape(Circle())
            }
        }
        
        .navigationDestination(for: String.self, destination: { value in
            WebView(url: value)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
        })
        .padding()
        
        
        
    }
}

#Preview {
    NewView(new: New(id: "ss", author: "Enes Talha Uçar", title: "Enes Talha Uçar Appcent Firmasında staja başladı", url: "https://www.appcent.mobi/", publishedAt: Date(), urlToImage: "https://pbs.twimg.com/profile_images/1771829489321828352/2uZEQB2__400x400.jpg", description: "Boğaziçi Üniversitesi Yönetim Bilişim Sistemleri 3. sınıf öğrencisi Enes Talha Uçar, yaz stajı için önde gelen bir yazılım şirketi olan Appcent'te iOS Development Intern pozisyonunda işe başladı. Uçar, mobil uygulama geliştirme konusundaki tutkusu ve teknik yetenekleriyle dikkat çekiyor.Appcent, yenilikçi mobil çözümler geliştiren ve sektördeki öncü projelere imza atan bir firma olarak biliniyor. Enes Talha Uçar, bu prestijli firma bünyesinde iOS platformu üzerindeki projelere katkıda bulunacak ve deneyim kazanacak.Konuyla ilgili açıklamalarda bulunan Uçar, Appcent gibi önde gelen bir firmada iOS geliştirme stajı yapacak olmaktan dolayı çok heyecanlıyım. Boğaziçi Üniversitesi'nde aldığım eğitim ve bu staj deneyimiyle kendimi daha da geliştireceğim. Mobil teknolojiler alanında kariyerime sağlam bir adım atmış olacağım için mutluyum dedi.Enes Talha Uçar'ın Appcent'teki stajı, hem kişisel gelişimi hem de profesyonel kariyeri için önemli bir adım olarak görülüyor. Uçar'ın, mobil uygulama geliştirme alanındaki bilgi ve becerilerini artırması ve sektörde kendine sağlam bir yer edinmesi bekleniyor."))
        .environmentObject(SavedViewModel())
}


struct WebView : UIViewRepresentable {
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    var url : String
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        return view
    }
}
