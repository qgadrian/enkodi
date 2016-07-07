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
    
    static var instance: RequestFacade?
    
    var requestProvider: Requestable!
        
    let socket = WebSocket(url: NSURL(string: "ws://192.168.0.23:9090/jsonrpc")!)
    
    static func getInstance(requestProtocol: RequestProtocol) -> RequestFacade {
        if ((instance) == nil) {
            instance = RequestFacade(requestProtocol: requestProtocol)
        }
        
        return instance!
    }
    
    private init?(requestProtocol: RequestProtocol) {
        switch requestProtocol.protocolType {
        case RequestProtocolType.WEB_SOCKET:
            initializeSocket(requestProtocol.socketListener!)
            requestProvider = WebSocketHelper(socket: socket)
        case RequestProtocolType.REST:
            // TODO: not implemented yet
            requestProvider = WebSocketHelper(socket: socket)
        }
    }
    
    // MARK: Action requests
    
    func sendRequest(json: JSON) {
        checkAndOpenSocketConnection()
        requestProvider.sendRequest(json)
    }
    
    // Basic actions
    func sendInputAction(inputAction: InputAction) {
        let json = JsonHelper.getInputActionJson(inputAction)
        requestProvider.sendRequest(json)
    }
    
    // Player actions
    func sendPlayPause() {
        let json = JsonHelper.getPlayPauseJson()
        requestProvider.sendRequest(json)
    }
    
    func sendStop() {
        let json = JsonHelper.getStopJson()
        requestProvider.sendRequest(json)
    }
    
    func sendSetVolume(volume: Int) {
        let json = JsonHelper.getSetVolumeJson(volume)
        requestProvider.sendRequest(json)
    }
    
    func sendGetApplicationProperties(requestId: UInt32) {
        let json = JsonHelper.getGetApplicationPropertiesJson(requestId)
        requestProvider.sendRequest(json)
    }
    
    // Player info
    func sendGetPlayerProperties(requestId: UInt32) {
        let json = JsonHelper.getGetPlayerProperties(requestId)
        requestProvider.sendRequest(json)
//        requestProvider.sendRequestForObject(json, PlayerProperties.self)
    }
    
    // Video library
    func sendGetTvShows(requestId: UInt32) {
        let json = JsonHelper.getGetTvShows(requestId)
        requestProvider.sendRequest(json)
    }
    
    //Web socket private methods
    private func initializeSocket(webSocketListener: WebSocketDelegate) {
        if (!socket.isConnected) {
            socket.connect()
        }
        socket.delegate = webSocketListener
    }
    
    private func checkAndOpenSocketConnection() {
        if (requestProvider is WebSocketHelper) {
            let webSocketHelper = requestProvider as! WebSocketHelper
            if (!webSocketHelper.socket.isConnected) {
                webSocketHelper.socket.connect()
            }
        }
    }
    
}
