//
//  HomeView.swift
//  Crypto
//
//  Created by T D on 2022/2/16.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio:Bool = false
    @State private var showPortfolioView:Bool = false //sheet
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()

                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                }
                
            
            VStack{
                
            
                homeHeader
                
                Spacer(minLength: 0)
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio{
                    allCoinList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio{
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.vm)
        
            
    }
}


extension HomeView{
    var homeHeader:some View{
        HStack{

            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: UUID())
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture {
                    showPortfolioView.toggle()
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: UUID())
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                    
                }
        }
        .padding(.horizontal)
    }
    
    var columnTitles:some View{
        HStack{
            
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holding")
            }

            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
            Button {
                withAnimation(.linear(duration: 2)){
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0),anchor: .center)
            }

            
           
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    var allCoinList:some View{
        
        List{
            ForEach(vm.allCoin) { coin in
                CoinRowView(coin: coin, showHoldingCurrency: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
            .listStyle(PlainListStyle())
            
            
    }
    
    var portfolioCoinList:some View{
        
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingCurrency: true)
                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
            .listStyle(PlainListStyle())
    }
}
