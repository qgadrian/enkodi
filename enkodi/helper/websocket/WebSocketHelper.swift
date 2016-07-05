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

class WebSocketHelper : RequestFacade {
    
    var socket: WebSocket
    
    let baseJson = JSON(["jsonrpc" : "2.0", "id" : 1])
    
    required init(socket: WebSocket) {
        self.socket = socket
    }
    
    internal func sendRequest(json: JSON) {
        let nsData = try! json.rawData()
        socket.writeData(nsData)
    }
    
    func sendPlayPause() {
        var json = baseJson
        json["method"].string = "Player.PlayPause"
        json["params"] = ["playerid" : 1]
        
        sendRequest(json)
    }
    
    func sendSetVolume(volume: Int) {
        var json = baseJson
        json["method"].string = "Application.SetVolume"
        json["params"] = ["volume" : volume]
        
        sendRequest(json)
    }
}