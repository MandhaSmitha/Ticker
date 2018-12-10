//
//  TickerViewModel.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import Foundation
import Starscream

class TickerViewModel: NSObject {
    var updateTickerData: ((String, Bool) -> Void)?
    var symbol: Int?
    var bitPloniexService: BitPoloniexService
    
    init(service: BitPoloniexService) {
        self.bitPloniexService = service
        super.init()
    }
    
    func getData(forSymbol id: Int) {
        symbol = id
        bitPloniexService.delegate = self
        bitPloniexService.subscribe(toSymbol: id)
    }
}

extension TickerViewModel: BitPoloniexServiceDelegate {
    func didReceiveTickerUpdate(tickerModel: TickerModel) {
        let tickerDetail = tickerModel.tickerDetail
        guard let tradePrice = tickerDetail?.tradePrice,
            let percentageChange = tickerDetail?.percentageChange,
            let percentageValue = Double(percentageChange) else {
                return
        }
        updateTickerData?(tradePrice, percentageValue >= 0.0 ? true : false)
    }
}
