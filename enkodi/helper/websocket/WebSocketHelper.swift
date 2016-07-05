//
//  WebSocketHelper.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import SwiftyJSON
import Starscream

class WebSocketHelper : Requesting {
    
    var socket: WebSocket
    
    required init(socket: WebSocket) {
        self.socket = socket
    }
    
    internal func sendRequest(json: JSON) {
        let nsData = try! json.rawData()
        socket.writeData(nsData)
    }
    
}