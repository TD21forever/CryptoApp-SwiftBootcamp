//
//  SettingsView.swift
//  Crypto
//
//  Created by T D on 2022/4/9.
//

import SwiftUI

struct SettingsView: View {
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.nicksarno.com")!
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.theme.background
                    .ignoresSafeArea()
                 
                List{
                    swiftfulThinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
          
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkView()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView{
    private var swiftfulThinkingSection:some View{
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width:100,height: 100)
                    .clipShape((RoundedRectangle(cornerRadius: 20)))
                Text("This app was make by following a @SwiftfulThinking course on YouTube. It use MVVM Architecture, Combine, and CoreData!")
            }
            .padding(.vertical)
            Link("Subscribe on YouTube",destination: youtubeURL)
            Link("Support his coffee addiction",destination: coffeeURL)
        }
    }
    
    private var coinGeckoSection:some View{
        Section(header: Text("coinGecko")) {
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape((RoundedRectangle(cornerRadius: 20)))
                Text("The cryptocurrency data that is used this app comes from a free API from CoinGecko! Prices mey be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coingeckoURL)
        }
    }
    
    private var developerSection:some View{
        Section(header: Text("Developer")) {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100, height: 100)
                    .clipShape((RoundedRectangle(cornerRadius: 20)))
                Text("This app was developed by Nick Sarno. It uses SwiftUI and is written 100% in Swift The project benefits from multi-threading, publishers/subscibers, and data psersistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website", destination: personalURL)
        }
    }
    
    private var applicationSection:some View{
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }
    }
    
}
