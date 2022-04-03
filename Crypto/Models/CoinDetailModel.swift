//
//  CoinDetailModel.swift
//  Crypto
//
//  Created by T D on 2022/3/28.
//

import Foundation

// JSON DATA
/*
 URL:https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false

 RESPONSE

 {
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "asset_platform_id": null,
   "platforms": {
     "": ""
   },
   "block_time_in_minutes": 10,
   "hashing_algorithm": "SHA-256",
   "categories": [
     "Cryptocurrency"
   ],
   "public_notice": null,
   "additional_notices": [],
   "description": {
     "en": "Bitcoin is the first successful internet money based on peer-to-peer technology; whereby no central bank or authority is involved in the transaction
   },
   "links": {
     "homepage": [
       "http://www.bitcoin.org",
       "",
       ""
     ],
     "blockchain_site": [
       "https://blockchair.com/bitcoin/",
       "https://btc.com/",
       "https://btc.tokenview.com/",
       "",
 
     ],
     "official_forum_url": [
       "https://bitcointalk.org/",
       "",
       ""
     ],
     "chat_url": [
       "",
       "",
       ""
     ],
     "announcement_url": [
       "",
       ""
     ],
     "twitter_screen_name": "bitcoin",
     "facebook_username": "bitcoins",
     "bitcointalk_thread_identifier": null,
     "telegram_channel_identifier": "",
     "subreddit_url": "https://www.reddit.com/r/Bitcoin/",
     "repos_url": {
       "github": [
         "https://github.com/bitcoin/bitcoin",
         "https://github.com/bitcoin/bips"
       ],
       "bitbucket": []
     }
   },
   "image": {
     "thumb": "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png?1547033579",
     "small": "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579",
     "large": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579"
   },
   "country_origin": "",
   "genesis_date": "2009-01-03",
   "sentiment_votes_up_percentage": 90.16,
   "sentiment_votes_down_percentage": 9.84,
   "market_cap_rank": 1,
   "coingecko_rank": 1,
   "coingecko_score": 81.178,
   "developer_score": 98.923,
   "community_score": 74.645,
   "liquidity_score": 100.056,
   "public_interest_score": 0.28,
   "public_interest_stats": {
     "alexa_rank": 9440,
     "bing_matches": null
   },
   "status_updates": [],
   "last_updated": "2022-03-28T12:25:29.123Z"
 }
 
 */


struct CoinDetailModel: Identifiable, Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}

struct Description:Codable {
    let en: String?
}
