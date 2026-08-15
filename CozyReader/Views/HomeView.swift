//
//  HomeView.swift
//  CozyReader
//
//  Created by Albert Barbu on 14/08/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
   
    var body: some View {
                VStack {
                    Text("HOME")
                        .shadow(radius: 1, y: 4)
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("Text"))
                        .underline(true, color: Color("Text"))
                
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()) ], spacing: 15){
                            
                            ForEach(viewModel.displayableManga) { manga in
                                if let mangaTitle = manga.attributes.title["en"] {
                                    MangaCardView(
                                        manga: manga,
                                        mangaTitle: mangaTitle
                                    )
                                    .task{
                                        if manga.id == viewModel.displayableManga.last?.id{
                                            await viewModel.loadManga()
                                        }
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
            

        .task {
            await viewModel.loadManga()
        }
        

    }
}

#Preview {
    HomeView()
}
