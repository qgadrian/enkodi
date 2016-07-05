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

class RequestFacade {
    
    var requestProvider: Requesting!
    
    required init?(requestClass: RequestClass, socket: WebSocket) {
        switch requestClass {
        case RequestClass.WEB_SOCKET:
            requestProvider = WebSocketHelper(socket: socket)
        case RequestClass.REST:
            // TODO: not implemented yet
            requestProvider = WebSocketHelper(socket: socket)
        }
    }
    
    func sendRequest(json: JSON) {
        requestProvider.sendRequest(json)
    }
    
    // Basic actions
    func sendInputAction(inputAction: InputAction) {
        let json = JsonRequestHelper.getInputActionJson(inputAction)
        requestProvider.sendRequest(json)
    }
    
    // Player actions
    func sendPlayPause() {
        let json = JsonRequestHelper.getPlayPauseJson()
        requestProvider.sendRequest(json)
    }
    
    func sendStop() {
        let json = JsonRequestHelper.getStopJson()
        requestProvider.sendRequest(json)
    }
    
    func sendSetVolume(volume: Int) {
        let json = JsonRequestHelper.getSetVolumeJson(volume)
        sendRequest(json)
    }
    
}
