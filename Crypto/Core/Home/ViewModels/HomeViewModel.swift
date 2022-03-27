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
    
    
    
    @Published var isLoading:Bool = false
    @Published var searchText:String = ""
    @Published var sortOption:SortOption = .holding
    
    var stats:[StatisticModel] = []
     
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    
    enum SortOption{
        case coin,coinReverse,price,priceReverse,holding,holdingReverse
    }
    
    init(){
        addSubscribers()
    }
    
    func updatePortfolio(coin:CoinModel, amount: Double){
        portfolioDataService.updatePortfolioData(coin: coin, amount: amount)
    }
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    func addSubscribers(){
     
           
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .combineLatest(coinDataService.$allCoin,$sortOption)
            .map(filterCoinsAndSort)
            .sink { [weak self] coins in
                self?.allCoin = coins
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
                // 对于holding的排序,只针对receivedCoins
                guard let self = self else {return}
                let sortedCoins = self.sortPortfolioHolding(coins: receivedCoins)
                self.portfolioCoins = sortedCoins
              
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketData)
            .sink { [weak self] stats in
                self?.stats = stats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
    
    }
    
    func filterCoinsAndSort(text:String,coins:[CoinModel],sort:SortOption)->[CoinModel]{
        var filteredAndsortedCoins = filterCoins(text: text, coins: coins)
        sortCoin(sort: sort, coins: &filteredAndsortedCoins)
        return filteredAndsortedCoins
        
    }
    
    private func sortPortfolioHolding(coins: [CoinModel]) -> [CoinModel]{
        
        switch sortOption {
            case .holding:
                return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
            case .holdingReverse:
                return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
            default:
                 return coins
        }
    }
    
    func sortCoin(sort:SortOption,coins: inout [CoinModel]){
        switch sort {
        case .coin,.holding:
                coins.sort(by: {$0.rank < $1.rank})
        case .coinReverse,.holdingReverse:
                coins.sort(by: {$0.rank > $1.rank})
            case .price:
                coins.sort(by: {$0.currentPrice < $1.currentPrice})
            case .priceReverse:
                coins.sort(by: {$0.currentPrice > $1.currentPrice})
        }
    }
    
    func filterCoins(text:String, coins:[CoinModel])->[CoinModel]{
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
    
    func mapMarketData(data:MarketData?,portfolioCoins:[CoinModel])->[StatisticModel]{
        var stats:[StatisticModel] = []
        guard let marketData = data else {return stats}
        
        
        let marketCap = StatisticModel(title: "Market Cap", value: marketData.marketCap,percentageChange: marketData.marketCapChangePercentage24HUsd)
        
        
        let volumn = StatisticModel(title: "24h Volume", value: marketData.volumn)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: marketData.btcDominance)
        
        
        let portfolioValue =
            portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
        let previousValue =
            portfolioCoins
            .map { (coin)->Double in
                let oldValue = coin.currentPrice / (1 + (coin.priceChangePercentage24H ?? 0) / 100)
                return (coin.currentPrice - oldValue) / oldValue
            }
            .reduce(0, +)
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: previousValue)
        
        stats.append(contentsOf: [
            marketCap,
            volumn,
            btcDominance,
            portfolio
        
        ])
        return stats
    }
    
}
