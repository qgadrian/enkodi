//
//  BaseViewController.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import Starscream
import SwiftyJSON
import ObjectMapper

class BaseViewController : UIViewController, WebSocketDelegate {
    
    let socket = WebSocket(url: NSURL(string: "ws://192.168.0.23:9090/jsonrpc")!)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if (!socket.isConnected) {
            socket.connect()
        }
    }
    
    // MARK: Websocket Delegate Methods.
    
    func websocketDidConnect(ws: WebSocket) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
            print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(ws: WebSocket, text: String) {
        print("Received text: \(text)")
    }
    
    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        print("Received data: \(data.length)")
    }
    
}