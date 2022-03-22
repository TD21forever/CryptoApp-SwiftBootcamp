//
//  HomeViewModel.swift
//  Crypto
//
//  Created by T D on 2022/2/17.
//

import Foundation
import Combine

class HomeViewModel:ObservableObject{
    
    @Published var allCoin:[CoinModel] = []
    @Published var portfolioCoins:[CoinModel] = []
    
    @Published var searchText:String = ""
    
    
    var stats:[StatisticModel] = []
     
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(){
        addSubscribers()
    }
    
    func updatePortfolio(coin:CoinModel, amount: Double){
        portfolioDataService.updatePortfolioData(coin: coin, amount: amount)
    }
    
    func addSubscribers(){
     
           
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .combineLatest(coinDataService.$allCoin)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoin = coins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
           
            .map(mapMarketData)
            .sink { [weak self] stats in
                self?.stats = stats
            }
            .store(in: &cancellables)
        
        $allCoin
            .combineLatest(portfolioDataService.$savedData)
            .map { (coinModels,portfolioModels) -> [CoinModel] in
                
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioModels.first(where: { $0.coinID == coin.id } ) else { return nil }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] receivedCoins in
                
                self?.portfolioCoins = receivedCoins
            }
            .store(in: &cancellables)
        
            
    }
    
    func filterCoins(text:Publishers.Debounce<Published<String>.Publisher, DispatchQueue>.Output, coins:Published<[CoinModel]>.Publisher.Output)->[CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            return coin.symbol.lowercased().contains(lowercasedText)  ||
            coin.id.lowercased().contains(lowercasedText) ||
            coin.name.lowercased().contains(lowercasedText)
        }
    }
    
    func mapMarketData(data:MarketData?)->[StatisticModel]{
        var stats:[StatisticModel] = []
        guard let marketData = data else {return stats}
        
        
        let marketCap = StatisticModel(title: "Market Cap", value: marketData.marketCap,percentageChange: marketData.marketCapChangePercentage24HUsd)
        
        
        let volumn = StatisticModel(title: "24h Volume", value: marketData.volumn)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: marketData.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volumn,
            btcDominance,
            portfolio
        
        ])
        return stats
    }
    
}
