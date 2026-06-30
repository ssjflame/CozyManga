//
//  ContentView.swift
//  CozyReader
//
//  Created by Albert Barbu on 22/06/2026.
//

import SwiftUI

struct Card: Identifiable{
    let id = UUID()
    let title: String
    let imageName: String
    let chapter: Int
        
    }



struct HomeView: View {
    var body: some View{
            
            TabView{
                Tab("", systemImage: "house"){
                    VStack{
                        Text("Home")
                            .shadow(radius: 1, y: 4)
                            .font(Font.largeTitle.bold())
                            .foregroundStyle(Color("Text"))
                            
                      
                    }
                    .background{
                        LinearGradient(colors:
                                        [
                                            Color.white,
                                            Color("Background"),
                                            Color("Background"),
                                            Color("Background2"),
                                            Color("Background2"),
                                            Color("Background"),
                                            Color("Background"),
                                            Color.white
                                        ],
                                       
                                       startPoint: .top, endPoint: .bottom )
                        .ignoresSafeArea()
                    }
                   
                }
                
                
                
                
                
                
                Tab("", systemImage: "gearshape"){
                    Settings()
                        .background(Color("Background"))
                    
                    
                }
                
                
                
                
            }
            .tint(Color.black)
    }
   
}


struct homeCard: View{
    let currentImageName : String
    let currentTitle : String
    let currentChapter : Int
    
    var body: some View {
        
        
        
            Button{
                
            }
            label: {
                VStack(alignment: .center){
                    
                    Image(currentImageName)
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
                        homeCard(currentImageName: card.imageName, currentTitle : card.title, currentChapter: card.chapter   )
                        
                        
                    }
                    
                    
                }
                
                
            
        }
    }
        
        
    
    

    

    
    


            
            
            



    


    
    





#Preview {
    HomeView()
}
