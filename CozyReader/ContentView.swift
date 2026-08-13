//
//  ContentView.swift
//  CozyReader
//
//  Created by Albert Barbu on 22/06/2026.
//


import SwiftUI
import Foundation

struct MangaResponse: Decodable {
    let data: [Manga]
}

struct Manga: Decodable, Identifiable {
    let id: String
    let attributes: MangaAttributes
    let relationships: [Relationship]

    var coverURL: URL?{
        guard let coverFileName = getCoverFileName(for: self)else{return nil}
        
        return URL(string: "https://uploads.mangadex.org/covers/\(id)/\(coverFileName).256.jpg")
        
        
        
    }
}

struct MangaAttributes: Decodable {
    let title: [String: String]
}

struct Relationship: Decodable {
    let id: String
    let type: String
    let attributes: RelationshipAttributes?
}

struct RelationshipAttributes: Decodable{
    let fileName: String?
}

func fetchManga() async throws -> [Manga] {
    guard let url = URL(
        string: "https://api.mangadex.org/manga?title=poo&limit=100&includes[]=cover_art"
    ) else {
        return []
    }

    let (data, _) = try await URLSession.shared.data(from: url)

    let decodedResponse = try JSONDecoder().decode(
        MangaResponse.self,
        from: data
    )

    return decodedResponse.data
    
}

func getCoverFileName(for manga: Manga) -> String? {
    guard let coverRelationship = manga.relationships.first(where: {
        $0.type == "cover_art"
    }
    )
    else{return nil}

    return coverRelationship.attributes?.fileName
}



struct Card: Identifiable{
    let id = UUID()
    let title: String
    let imageName: String
    let chapter: Int
        
    }





struct HomeView: View {
    @State private var mangaResults: [Manga] = []

    var body: some View {
        TabView {
            Tab("", systemImage: "house") {
                VStack {
                    Text("HOME")
                        .shadow(radius: 1, y: 4)
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("Text"))
                        .underline(true, color: Color("Text"))
                
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()) ], spacing: 15){
                        ForEach(mangaResults) { manga in
                            
                            if let englishTitle = manga.attributes.title["en"]{
                                
                                Button{
                                    
                                }label:{
                                    
                                    VStack(alignment: .center){
                                        
                                        AsyncImage(url: manga.coverURL){ image in
                                            image
                                                .resizable()
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(.ultraThinMaterial.opacity(0.45), lineWidth: 5)
                                                }
                                                .frame(width:120, height:180)
                                                .scaledToFill()
                                               
                                            
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text(englishTitle)
                                            .frame(width:60, height:150)
                                        
                                    }
                                    .frame(width:120, height:280)
                                    
                                    // WAS WORKING HERE TRYING TO MAKE SURE THE GRID OBJECTS DONT OVERLAP
                                }
                                
                            }
                            
                            }
                        }
                    }
                }
                .background {
                    LinearGradient(
                        colors: [
                            Color.white,
                            Color("Background"),
                            Color("Background"),
                            Color("Background2"),
                            Color("Background2"),
                            Color("Background"),
                            Color("Background"),
                            Color.white
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
            }
        
            Tab("", systemImage: "gearshape") {
                Settings()
                    .background(Color("Background"))
            }
        }
        .tint(Color.black)
        .task {
            do {
                mangaResults = try await fetchManga()
            } catch {
                print("Failed to fetch manga: \(error.localizedDescription)")
            }
        }
    
    }
}



struct homeCard: View{
    let currentCover : String
    let currentTitle : String
    let currentChapter : Int

    var body: some View {
    
    
    
        Button{
            
        }
        label: {
            VStack(alignment: .center){
                
                Image(currentCover)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.ultraThinMaterial.opacity(0.45), lineWidth: 5)
                    }
                    
                    .scaledToFit()
                    .frame(width:150, height:150)
                
                Text(currentTitle)
                
                Text("Ch: " + String(currentChapter))
                    .font(.caption)
                
                    
            }
            
        }
        .foregroundColor(Color("Text"))
        .bold(true)
        
        
        
        
    }
}

struct homeCardGen: View{

    let images = ["Manga1", "Manga2", "Manga3", "Manga4", "Manga5"]
    let titles = ["Manga1", "Manga2", "Manga3", "Manga4", "Manga5"]
    let chapters =  [30, 50, 21, 80,67]

    let Cards = [
        Card(title: "Manga1", imageName: "Manga1" , chapter: 30),
        Card(title: "Manga2", imageName: "Manga2", chapter: 50),
        Card(title: "Manga3", imageName: "Manga3", chapter: 21),
        Card(title: "Manga4", imageName: "Manga4", chapter: 80),
        Card(title: "Manga5", imageName: "Manga5", chapter: 67),
        Card(title: "Manga6", imageName: "Manga1", chapter: 37)
                ]




    var body: some View {
        
        
            
                                   
                
                    
                    
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()) ], spacing: 8){
                
                
            ForEach(Cards){ card in
                homeCard(currentCover: card.imageName, currentTitle : card.title, currentChapter: card.chapter   )
                    
                    
            }
                
                
        }
            
            
        
    }
}
    
    









        
        
        







#Preview {
    HomeView()
}
