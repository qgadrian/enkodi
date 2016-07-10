//
//  RequestFacade.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import Starscream
import SwiftyJSON

protocol Requestable {
        
    func sendRequest(json: JSON)
    
    func sendRequestForObject<T: BaseModel>(json: JSON, _: T.Type) -> T?

}

// Connection protocols
class RequestProtocol {
    let socketListener: WebSocketDelegate?
    let protocolType: RequestProtocolType
    
    init(socketListener: WebSocketDelegate) {
        self.protocolType = RequestProtocolType.WEB_SOCKET
        self.socketListener = socketListener
    }
    
    init() {
        self.protocolType = RequestProtocolType.REST
        self.socketListener = nil
    }
}

enum RequestProtocolType {
    case WEB_SOCKET,  REST
}

// Send actions
enum InputAction {
    case UP, DOWN, RIGHT, LEFT
    case OK, BACK, HOME, INFO
}

enum ExecutionAction {
    case FORWARD, BACKWARD
}