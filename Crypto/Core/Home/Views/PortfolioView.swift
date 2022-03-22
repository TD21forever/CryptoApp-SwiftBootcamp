//
//  PortfolioView.swift
//  Crypto
//
//  Created by T D on 2022/3/15.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark:Bool = false
    
    var body: some View {
        NavigationView{
            
            
            ScrollView{
                VStack{
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinRowView
                    
                    if selectedCoin != nil{
                        portfolioInputView
                    }

                  
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkView()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            }
            
        }
     
        
    }

}

extension PortfolioView{
    var coinRowView: some View{
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing:10){
                
                ForEach(vm.searchText == "" ? vm.portfolioCoins : vm.allCoin) {
                    coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75)
                        .padding(4)
                        .onTapGesture {
                            updateSelectedCoin(coin:coin)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear)
                        )
                }
            }
          
        })
    }
    
    private func updateSelectedCoin(coin:CoinModel){
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        }else{
            quantityText = ""
        }
    }
    
    var portfolioInputView: some View{
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount holding:")
                    .lineLimit(2)
                    
                Spacer()
                TextField("Ex: 1.4",text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value:")
                Spacer()
                Text(getCurValue().asCurrencyWith2Decimals())
                
            }
        }
        .padding()
        .font(.headline)
    }
    
    func getCurValue()->Double{
        
        if let quantity = Double(quantityText){
            return (selectedCoin?.currentPrice ?? 0) * quantity
        }
        return 0
    }
    
    private var trailingNavBarButton: some View{
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                pressSaveButton()
            } label: {
                Text("SAVE")
            }
            .opacity(  ( selectedCoin != nil &&  selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        }
    }
    
    func pressSaveButton(){
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        
        // save portfolio
        vm.updatePortfolio(coin: coin, amount:amount)
        // checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // dismiss keyboard
        
        UIApplication.shared.endEditing()
        
        
        // checkmark
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            withAnimation(.easeOut) {
                showCheckmark = false

            }
        }
        
    }
    
    func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
        print(vm.searchText)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.vm)
    }
}
