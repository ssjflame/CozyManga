//
//  MangaCardView.swift
//  CozyReader
//
//  Created by Albert Barbu on 14/08/2026.
//

import SwiftUI

struct MangaCardView: View {
    let manga: Manga
    let mangaTitle: String
    var body: some View {
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
                
                Text(mangaTitle)
                    .frame(width:120, height:50)
                    .foregroundColor(Color("Text"))
                    .bold(true)
                
            }
            .frame(width:150, height:230)
            
            
        }
        
        
    }
    
}


