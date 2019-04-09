//
//  TickerViewModelTests.swift
//  TickerViewModelTests
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import XCTest
@testable import Ticker

class TickerViewModelTests: XCTestCase {
    var tickerViewModel: TickerViewModel!
    var tradePrice: String?
    var isPositiveChange: Bool?
    var tickerModel: TickerModel!
    var tickerModelNegativeChange: TickerModel!

    override func setUp() {
        tickerViewModel = TickerViewModel(service: BitPoloniexService())
        tickerViewModel.referencePrice = 70.0
        tickerViewModel.updateTickerData = { (price, isPositive) -> Void in
            self.tradePrice = price
            self.isPositiveChange = isPositive
        }
        let decoder = JSONDecoder()
        var text = "[1002,null,[169,\"70.67\",\"0.00277468\",\"0.00270821\",\"0.04706037\",\"3.29458269\",\"1198.08824841\",0,\"0.00279000\",\"0.00270429\"]]"
        tickerModel = try! decoder.decode(TickerModel.self, from: text.data(using: .utf8)!)
        text = "[1002,null,[169,\"0.00277471\",\"0.00277468\",\"0.00270821\",\"-0.04706037\",\"3.29458269\",\"1198.08824841\",0,\"0.00279000\",\"0.00270429\"]]"
        tickerModelNegativeChange = try! decoder.decode(TickerModel.self, from: text.data(using: .utf8)!)
    }

    override func tearDown() {
    }
    
    func testTickerUpdate() {
        //Positive Value
        tickerViewModel.didReceiveTickerUpdate(tickerModel: tickerModel)
        XCTAssert(tradePrice == "70.67")
        XCTAssertTrue(isPositiveChange!)
        
        //Negative Value
        tickerViewModel.didReceiveTickerUpdate(tickerModel: tickerModelNegativeChange)
        XCTAssert(tradePrice == "0.00277471")
        XCTAssertFalse(isPositiveChange!)
    }
}
