//
//  CoinImageView.swift
//  Crypto
//
//  Created by T D on 2022/3/5.
//

import SwiftUI

struct CoinImageView: View {
    
    
    @StateObject var vm:CoinImageViewModel
    
    // 这里的ViewModel需要传入参数
    init(coin:CoinModel){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin) )
    }
    
    
    
    var body: some View {
        
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                
                ProgressView()
            }
            else {
                
                Image(systemName: "questionmark")
            }
            
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
