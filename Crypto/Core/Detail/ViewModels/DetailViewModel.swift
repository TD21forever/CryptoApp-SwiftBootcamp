//
//  DetailViewModel.swift
//  Crypto
//
//  Created by T D on 2022/3/28.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject{
    
    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    @Published var overviewStatistic:[StatisticModel] = []
    @Published var additionalStatistic:[StatisticModel] = []
    
    @Published var coin:CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapCoinDetails)
            .sink { [weak self] returnedCoinDetails in
                self?.additionalStatistic = returnedCoinDetails.additional
                self?.overviewStatistic = returnedCoinDetails.overview
            }
            .store(in: &cancellables)
    }
    
    private func mapCoinDetails(coinDetailModel:CoinDetailModel?,coinModel:CoinModel)->(overview:[StatisticModel],additional:[StatisticModel]){
        
            // overview
            let overViewArray = createOverviewModel(coinModel: coinModel)
            
            // additional
            let additionalArray = createAdditionalModel(coinModel: coinModel, coinDetailModel: coinDetailModel)
            
                    
            return (overViewArray,additionalArray)
    }
    
    private func createOverviewModel(coinModel:CoinModel)->[StatisticModel]{
        // overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
    
        let rank = "\(coinModel.rank)"
        let ransStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        return [
            priceStat,marketCapStat,ransStat,volumeStat
        ]
    }
    
    private func createAdditionalModel(coinModel:CoinModel,coinDetailModel:CoinDetailModel?)->[StatisticModel]{
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24 High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24 Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        return [
            highStat,lowStat,priceChangeStat,marketCapChangeStat,blockStat,hashingStat
        ]
    }
}
