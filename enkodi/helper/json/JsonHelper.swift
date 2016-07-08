//
//  JsonRequestHelper.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonHelper {
    
    // Base json attributes
    static let methodKey = "method"
    static let paramsKey = "params"
    static let playerIdKey = "playerid"
    static let propertiesKey = "properties"
    static let resultKey = "result"
    static let requestIdKey = "id"
    static let dataKey = "data"
    
    static let baseJson = JSON(["jsonrpc" : "2.0", requestIdKey : 1])
    
    static func getInputActionJson(inputAction: InputAction) -> JSON {
        var json = baseJson
        var inputActionString: String?
        
        switch (inputAction) {
        case InputAction.UP:
            inputActionString = ApiAction.Input.up
        case InputAction.DOWN:
            inputActionString = ApiAction.Input.down
        case InputAction.LEFT:
            inputActionString = ApiAction.Input.left
        case InputAction.RIGHT:
            inputActionString = ApiAction.Input.right
        case InputAction.OK:
            inputActionString = ApiAction.Input.select
        case InputAction.BACK:
            inputActionString = ApiAction.Input.back
        case InputAction.HOME:
            inputActionString = ApiAction.Input.home
        }
        
        json[methodKey].string = inputActionString
        
        return json
    }
    
    static func getPlayPauseJson() -> JSON {
        var json = baseJson
        json[methodKey].string = ApiAction.Player.playPause;
        json[paramsKey] = [playerIdKey : 1]
        
        return json
    }
    
    static func getStopJson() -> JSON {
        var json = baseJson
        json[methodKey].string = ApiAction.Player.stop
        json[paramsKey] = [playerIdKey : 1]
        
        return json
    }
    
    static func getSetVolumeJson(volume: Int) -> JSON {
        var json = baseJson
        json[methodKey].string = ApiAction.Application.setVolume
        json[paramsKey] = ["volume" : volume]
        
        return json
    }
    
    static func getGetApplicationPropertiesJson(requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.Application.getProperties
        json[paramsKey] = [propertiesKey : [
            "volume",
            "muted",
            "name",
            "version"]]
        
        return json
    }
    
    static func getGetPlayerProperties(requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.Player.getProperties
        json[paramsKey] = [playerIdKey : 1, propertiesKey : [
                           "speed",
                           "percentage",
                           "audiostreams",
                           "currentsubtitle",
                           "type",
                           "subtitles",
                           "time",
                           "totaltime",
                           "live",
                           "subtitleenabled",
                           "currentaudiostream"]]
        
        return json
    }
    
    static func getGetTvShows(requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.VideoLibrary.getTvShows
        
        return json
    }

    
}