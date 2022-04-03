//
//  CoinDetailService.swift
//  Crypto
//
//  Created by T D on 2022/3/28.
//

import Foundation
import Combine

class CoinDetailService{
    
    @Published var coinDetails:CoinDetailModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin:CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinDetail()
    }
    
    // 这里不用传参数吗
    func getCoinDetail(){
        guard
            let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
            else{ return }
        
        coinDetailSubscription = NetworkManage.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManage.handleCompletion){ [weak self] (returnedDetailData) in
                self?.coinDetails = returnedDetailData
                self?.coinDetailSubscription?.cancel()
            }
    }
}
