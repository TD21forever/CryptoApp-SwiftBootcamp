//
//  CoinViewModel.swift
//  Crypto
//
//  Created by T D on 2022/2/17.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingCurrency:Bool
    
    var body: some View {
        HStack(spacing:0){
            leftColumn
            Spacer()
            if showHoldingCurrency{
               centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin: dev.coin,showHoldingCurrency: true)
                
            CoinRowView(coin: dev.coin,showHoldingCurrency: true)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .padding()
        
    }
}

extension CoinRowView{
    private var leftColumn: some View{
        HStack(spacing:0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
        }
    }
    private var centerColumn: some View {
        
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? "$0.00")
        }
        .foregroundColor(Color.theme.accent)
    }
    private var rightColumn: some View{
        VStack(alignment:.trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .foregroundColor(Color.theme.accent)
                .bold()
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                    Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
    }
}
