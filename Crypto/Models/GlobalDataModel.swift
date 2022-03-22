//
//  GlobalDataModel.swift
//  Crypto
//
//  Created by T D on 2022/3/13.
//

import Foundation

// Global Data Model
/*

 URL: https://api.coingecko.com/api/v3/global
 
 Response:
 
 {
   "data": {
     "active_cryptocurrencies": 13096,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 771,
     "total_market_cap": {
       "btc": 46642193.3755642,
       "eth": 706081479.858826,
       "ltc": 17222430716.09002,
       "usd": 1826274268117.2803,
       "aed": 6708088014221.575,
       "ars": 198687863526704,
       "aud": 2503986386272.922,
       "bdt": 156888540036408.78,
       "sats": 4664219337556420
     },
     "total_volume": {
       "btc": 1383036.7994353215,
       "eth": 20936765.605798304,
       "ltc": 510680431.86315066,
       "bch": 184142716.2414153,
       "bnb": 144286923.607348,
       "eos": 27062974231.719147,
       "xrp": 67695702596.26331,
       "xlm": 290576687552.95593,
       "link": 4053849204.367706,
       "dot": 2975091171.512752,
       "yfi": 2920170.4111943557,
       "usd": 54152781759.85767,
       "aed": 198908582682.13303,
       "ars": 5891503099907.352,
       "try": 799538746293.4186,
       "twd": 1538615911751.9534,
       "uah": 1589246434127.8108,
       "vef": 5422318037.614557,
       "vnd": 1238744882756745,
       "zar": 814782754358.8196,
       "xdr": 38772037920.514175,
       "xag": 2097322074.7803931,
       "xau": 27239932.280843657,
       "bits": 1383036799435.3215,
       "sats": 138303679943532.14
     },
     "market_cap_percentage": {
       "btc": 40.69706981221139,
       "eth": 16.987502591247353,
       "usdt": 4.3843487579737666,
       "bnb": 3.458329672057482,
       "usdc": 2.867946608672179,
       "xrp": 2.1037694200911363,
       "luna": 1.7884827192053074,
       "sol": 1.4526814331376992,
       "ada": 1.3980991465902604,
       "dot": 1.0885013832676413
     },
     "market_cap_change_percentage_24h_usd": -0.21006974131591588,
     "updated_at": 1647157690
   }
 }
 
*/

struct GlobalDataModel:Codable {
    let data: MarketData?
}


struct MarketData:Codable{
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys:String,CodingKey{
        
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        
    }
    
    var marketCap: String{
        
        if let item = totalMarketCap.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volumn: String{
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String{
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
        return ""
    }
}
