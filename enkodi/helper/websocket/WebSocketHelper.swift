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

class WebSocketHelper : Requestable {
    
    var socket: WebSocket
    
    required init(socket: WebSocket) {
        self.socket = socket
    }
    
    func sendRequest(json: JSON) {
        let nsData = try! json.rawData()
        socket.writeData(nsData)
    }
    
    func sendRequestForCompletion(json: JSON, completion: () -> ()) {
        let nsData = try! json.rawData()
        socket.writeData(nsData, completion: completion)
    }
    
    func sendRequestForObject<T: BaseModel>(json: JSON, _: T.Type) -> T? {
        let nsData = try! json.rawData()
        socket.writeData(nsData)
        
        // TODO: return type converted
        return nil
    }
    
}