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
    var referencePrice: Double!
    
    init(service: BitPoloniexService) {
        self.bitPloniexService = service
        super.init()
    }
    
    func getData(forSymbol id: Int) {
        symbol = id
        bitPloniexService.delegate = self
        bitPloniexService.subscribe(toSymbol: id)
    }
    
    func setReferencePrice(_ price: Double) {
        referencePrice = price
    }
}

extension TickerViewModel: BitPoloniexServiceDelegate {
    func didReceiveTickerUpdate(tickerModel: TickerModel) {
        let tickerDetail = tickerModel.tickerDetail
        guard let tradePrice = tickerDetail?.tradePrice,
            let tradeValue = Double(tradePrice) else {
                return
        }
        updateTickerData?(tradePrice, tradeValue >= referencePrice ? true : false)
    }
}
