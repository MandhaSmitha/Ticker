//
//  TickerModels.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit

struct TickerDetail: Decodable {
    var currencyPair: Int?
    var tradePrice: String?
    var lowestAsk: String?
    var highestBid: String?
    var percentageChange: String?
    var baseCurrencyVolume: String?
    var quoteCurrencyVolume: String?
    var isFrozen: Int?
    var highestPrice: String?
    var lowestPrice: String?
    
    init(detailContainer: UnkeyedDecodingContainer) throws {
        var detail = detailContainer
        currencyPair = try detail.decode(Int.self)
        tradePrice = try detail.decode(String.self)
        lowestAsk = try detail.decode(String.self)
        highestBid = try detail.decode(String.self)
        percentageChange = try detail.decode(String.self)
        baseCurrencyVolume = try detail.decode(String.self)
        quoteCurrencyVolume = try detail.decode(String.self)
        isFrozen = try detail.decode(Int.self)
        highestPrice = try detail.decode(String.self)
        lowestPrice = try detail.decode(String.self)
    }
}

struct TickerModel: Decodable {
    var id: Int?
    var subscriptionStatus: Int?
    var tickerDetail: TickerDetail?
    
    init(from decoder: Decoder) throws {
        var values = try decoder.unkeyedContainer()
        id = try values.decode(Int.self)
        subscriptionStatus = try values.decodeIfPresent(Int.self)
        let detail = try values.nestedUnkeyedContainer()
        tickerDetail = try TickerDetail(detailContainer: detail)
    }
}
