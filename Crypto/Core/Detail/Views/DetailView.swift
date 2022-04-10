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
    @State var isFullPage:Bool = false
    
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
            
            VStack{
                
                ChartView(coin: coin)
                    .padding(.vertical)
                
                
                VStack(spacing: 20){
                    overviewText
                    Divider()
                    descriptionView
                    overviewGrid
                    Divider()
                    additionalText
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
            }
        }
    }
}


extension DetailView{
    
    private var websiteSection : some View{
        // 这个意思是里面的元素左对齐
        VStack(alignment:.leading,spacing:20){
            if let websiteURL = vm.website, let website = URL(string: websiteURL){
                Link("Website", destination: website)
            }
            
            if let redditURL = vm.reddit,let reddit = URL(string: redditURL){
                Link("Reddit",destination: reddit)
            }
        }
        .accentColor(.blue)
        // 整个Vstack左对齐
        .frame(maxWidth:.infinity,alignment: .leading)
        .font(.headline)
    }
    
    private var navigationBarTrailingItem : some View{
        HStack{
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewText:some View{
        
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    private var descriptionView:some View{
        ZStack{
            if let description = vm.description, !description.isEmpty{
                VStack(alignment:.leading){
                    Text(description)
                        .font(.callout)
                        .lineLimit(isFullPage ? nil : 3)
                        .foregroundColor(.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            isFullPage.toggle()

                        }
                    } label: {
                        Text(isFullPage ? "Less" : "Read More")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical,4)
                    }
                    .accentColor(.blue)
                }
            }
        }
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
