//
//  DetailView.swift
//  Crypto
//
//  Created by T D on 2022/3/28.
//

import SwiftUI

struct DetailViewLoading:View{
    
    @Binding var coin:CoinModel?

    
    var body: some View {
        ZStack{
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    @StateObject var vm:DetailViewModel
    private let girdSpacing:CGFloat = 30
    private let columns:[GridItem] = [
        
        GridItem(.flexible()),
        GridItem(.flexible())
    
    ]
    let coin:CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                
                Text("")
                    .frame(height:200)
                
                overviewText
                overviewGrid
                
                Divider()
                
                additionalText
                additionalGrid
                
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}


extension DetailView{
    private var overviewText:some View{
        
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    
    private var overviewGrid:some View{
        
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: girdSpacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistic) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalText:some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    
    private var additionalGrid:some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: girdSpacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistic) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin: dev.coin)
        }
        
    }
}
