//
//  CoinDataService.swift
//  Crypto
//
//  Created by T D on 2022/2/26.
//

import Foundation
import Combine

class CoinDataService{
    
    @Published var allCoin:[CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init(){
        getCoins()
    }
    
    func getCoins(){
        guard
            let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
            else{ return }
        
        coinSubscription = NetworkManage.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManage.handleCompletion){ [weak self] (returnedData) in
                self?.allCoin = returnedData
                self?.coinSubscription?.cancel()
            }
    }
}
