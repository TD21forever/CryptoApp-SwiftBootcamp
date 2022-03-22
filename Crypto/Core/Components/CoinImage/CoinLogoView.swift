//
//  CoinLogoView.swift
//  Crypto
//
//  Created by T D on 2022/3/15.
//

import SwiftUI

struct CoinLogoView: View {
    var coin:CoinModel
    var body: some View {
        VStack{
            
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
      
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
    }
}
