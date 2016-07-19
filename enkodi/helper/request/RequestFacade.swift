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
    
    private static var instance: RequestFacade!
    
    var requestProvider: Requestable!
    
    static func getInstance(requestProtocol: RequestProtocol) -> RequestFacade {
        if ((RequestFacade.instance) == nil) {
            instance = RequestFacade(requestProtocol: requestProtocol)
        }
        
        return RequestFacade.instance!
    }
    
    private init?(requestProtocol: RequestProtocol) {
        switch requestProtocol.protocolType {
        case RequestProtocolType.WEB_SOCKET:
            requestProvider = WebSocketHelper(webSocketDelegate: requestProtocol.socketListener!)
        case RequestProtocolType.REST:
            // TODO: not implemented yet
//            requestProvider = WebSocketHelper()
            fatalError("not implemented yet")
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
        sendRequest(json)
    }
    
    func sendExecuteAction(executionAction: ExecutionAction) {
        let json = JsonHelper.getExecuteActionJson(executionAction)
        sendRequest(json)
    }
    
    // Player actions
    func sendPlayPause() {
        let json = JsonHelper.getPlayPauseJson()
        sendRequest(json)
    }
    
    func sendStop() {
        let json = JsonHelper.getStopJson()
        sendRequest(json)
    }
    
    func sendSetVolume(volume: Int) {
        let json = JsonHelper.getSetVolumeJson(volume)
        sendRequest(json)
    }
    
    func sendGetApplicationProperties(requestId: UInt32) {
        let json = JsonHelper.getGetApplicationPropertiesJson(requestId)
        sendRequest(json)
    }
    
    func sendSetSubtitle(subtitleIndex: Int?) {
        let json = JsonHelper.getSetSubtitleJson(subtitleIndex)
        sendRequest(json)
    }
    
    func sendSetAudio(audioStreamIndex: Int) {
        let json = JsonHelper.getSetAudioJson(audioStreamIndex)
        sendRequest(json)
    }
    
    // Player info
    func sendGetPlayerProperties(requestId: UInt32) {
        let json = JsonHelper.getGetPlayerProperties(requestId)
        sendRequest(json)
//        requestProvider.sendRequestForObject(json, PlayerProperties.self)
    }
    
    func sendPlayFile(file: String) {
        let json = JsonHelper.getSendPlayFile(file)
        sendRequest(json)
    }

    func sendGetCurrentlyPlaying(requestId: UInt32) {
        let json = JsonHelper.getGetCurrentlyPlaying(requestId)
        sendRequest(json)
    }
    
    // Video library
    func sendGetTvShows(requestId: UInt32) {
        let json = JsonHelper.getGetTvShows(requestId)
        sendRequest(json)
    }
    
    func sendGetTvShowSeasons(tvShowId: Int, requestId: UInt32) {
        let json = JsonHelper.getGetTvShowSeasons(tvShowId, requestId: requestId)
        sendRequest(json)
    }
    
    func sendGetAllTvShowSeasonsEpisodes(tvShowId: Int, requestId: UInt32) {
        let json = JsonHelper.getGetAllTvShowSeasonsEpisodes(tvShowId, requestId: requestId)
        sendRequest(json)
    }
    
    func sendGetTvShowEpisodeInfo(tvShowEpisodeId: Int, requestId: UInt32) {
        let json = JsonHelper.getGetTvShowEpisodeInfo(tvShowEpisodeId, requestId: requestId)
        sendRequest(json)
    }
    
    //MARK: Web socket private methods
    
    private func checkAndOpenSocketConnection() {
        if let webSocketProvider = requestProvider as! WebSocketHelper? {
            if (!webSocketProvider.socket.isConnected) {
                webSocketProvider.socket.connect()
            }
        }
    }
    
}
