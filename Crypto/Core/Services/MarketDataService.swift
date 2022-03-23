//
//  GlobalDataService.swift
//  Crypto
//
//  Created by T D on 2022/2/26.
//

import Foundation
import Combine

class MarketDataService{
    
    @Published var marketData:MarketData? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getMarketData()
    }
    
    func getMarketData(){
        guard
            let url = URL(string:"https://api.coingecko.com/api/v3/global")
            else{ return }
        
        marketDataSubscription = NetworkManage.download(url: url)
            .decode(type: GlobalDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManage.handleCompletion){ [weak self] (returnedData) in
                self?.marketData = returnedData.data
                self?.marketDataSubscription?.cancel()
            }
    }
}
