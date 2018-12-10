//
//  BitPoloniexService.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import Foundation
import Starscream

struct PoloniexServiceConstants {
    static let websocketURLString = "wss://api2.poloniex.com"
}

protocol BitPoloniexServiceDelegate: class {
    func didReceiveTickerUpdate(tickerModel: TickerModel)
}

class BitPoloniexService: NSObject {
    weak var delegate: BitPoloniexServiceDelegate?
    var symbol: Int?
    var socket: WebSocket?
    var heartbeat: Timer?
    var isConnected = false {
        didSet {
            if isConnected == true, symbol != nil {
                self.subscribe(toSymbol: symbol!)
            }
        }
    }
    
    func subscribe(toSymbol id: Int) {
        symbol = id
        if isConnected {
            socket?.write(string: String(format: "{\"command\": \"subscribe\",\"channel\": %d}", id))
        } else {
            connectToWebSocket()
        }
    }
    
    private func connectToWebSocket() {
        guard let url = URL(string: PoloniexServiceConstants.websocketURLString) else {
            return
        }
        socket = WebSocket(url: url)
        socket?.delegate = self
        socket?.connect()
    }
    
    private func getHearbeat() {
        guard let channel = symbol else {
            return
        }
        socket?.write(string: String(format: "{\"command\": \"subscribe\",\"channel\": %d}", channel))
    }
}

extension BitPoloniexService: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocket) {
        isConnected = true
        heartbeat = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.getHearbeat()
        }
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        isConnected = false
        heartbeat?.invalidate()
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        let decoder = JSONDecoder()
        do {
            let tickerModel: TickerModel = try decoder.decode(TickerModel.self, from: text.data(using: .utf8)!)
            
            DispatchQueue.main.async {
                self.delegate?.didReceiveTickerUpdate(tickerModel: tickerModel)
            }
        } catch {
            print(error)
        }
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        let decoder = JSONDecoder()
        do {
            let tickerModel: TickerModel = try decoder.decode(TickerModel.self, from: data)
            
            DispatchQueue.main.async {
                self.delegate?.didReceiveTickerUpdate(tickerModel: tickerModel)
            }
        } catch {
            print(error)
        }
    }
}
