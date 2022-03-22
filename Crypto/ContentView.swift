//
//  ContentView.swift
//  Crypto
//
//  Created by T D on 2022/2/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing:40){
                
                Text("BackgroundColor")
                    .foregroundColor(Color.theme.background)
                Text("Red")
                    .foregroundColor(Color.theme.red)
                Text("Green")
                    .foregroundColor(Color.theme.green)
                Text("Accent")
                    .foregroundColor(Color.theme.accent)
                Text("SecondaryText")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                
                
        }
    }
}
