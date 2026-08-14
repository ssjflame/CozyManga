//
//  ContentView.swift
//  CozyReader
//
//  Created by Albert Barbu on 22/06/2026.
//


import SwiftUI



struct ContentView: View {
    var body: some View {
        TabView {
            Tab("", systemImage: "house") {
                HomeView()
            }

            Tab("", systemImage: "gearshape") {
                SettingsView()
                    .background(Color("Background"))
            }
        }
        .tint(Color.black)
        
        }
    
    }



#Preview {
    ContentView()
}
