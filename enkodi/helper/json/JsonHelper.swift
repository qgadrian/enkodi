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
    static let sortKey = "sort"
    
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
        case InputAction.INFO:
            inputActionString = ApiAction.Input.info
        case InputAction.MENU:
            inputActionString = ApiAction.Input.menu
        }
        
        json[methodKey].string = inputActionString
        
        return json
    }
    
    static func getExecuteActionJson(executionAction: ExecutionAction) -> JSON {
        var json = baseJson
        var executionActionString: String?
        
        json[methodKey].string = ApiAction.Execution.action
        
        switch (executionAction) {
        case ExecutionAction.FORWARD:
            executionActionString = ApiAction.Execution.forward
        case ExecutionAction.BACKWARD:
            executionActionString = ApiAction.Execution.backward
        }
        
        json[paramsKey] = ["action" : executionActionString!]
        
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
    
    static func getSetSubtitleJson(subtitleIndex: Int?) -> JSON {
        var json = baseJson
        json[methodKey].string = ApiAction.Player.setSubtitle
        
        if (subtitleIndex != nil) {
            json[paramsKey] = [playerIdKey : 1, "subtitle" : subtitleIndex!, "enable" : true ]
        } else {
            json[paramsKey] = [playerIdKey : 1, "subtitle" : 0, "enable" : false ]
        }
        
        return json
    }
    
    static func getSetAudioJson(audioStreamIndex: Int) -> JSON {
        var json = baseJson
        json[methodKey].string = ApiAction.Player.setAudioStream

        json[paramsKey] = [playerIdKey : 1, "stream" : audioStreamIndex]
        
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
    
    static func getSendPlayFile(file: String) -> JSON {
        var json = baseJson
        json[methodKey].string = ApiAction.Player.playFile
        json[paramsKey] = ["item" : ["file" :file]]
        return json
    }
    
    static func getGetCurrentlyPlaying(requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.Player.getCurrentlyPlaying
        json[paramsKey] = [playerIdKey : 1, propertiesKey : [
            "title",
            "showtitle",
            "season",
            "year",
            "disc",
            "displayartist"]]
        
        return json
    }
    
    static func getGetBaseMovies(requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.VideoLibrary.getMovies
        json[paramsKey] = [sortKey : [methodKey: "label"], propertiesKey : [
            "title",
            "genre",
            "year",
            "rating",
            "tagline",
            "plot",
            "playcount",
            "country",
            "imdbnumber",
            "runtime",
            "file"
            ]]
        
        return json
    }
    
    static func getGetTvShows(requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.VideoLibrary.getTvShows
        json[paramsKey] = [sortKey : [methodKey: "label"]]
        
        return json
    }
    
    static func getGetTvShowSeasons(tvShowId:Int, requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.VideoLibrary.getTvShowSeasons
        
        json[paramsKey] = ["tvshowid" : tvShowId, propertiesKey : [
            "season",
            "showtitle",
            "playcount",
            "episode",
            "fanart",
            "thumbnail",
            "tvshowid",
            "watchedepisodes",
            "art"]]

        
        return json
    }
    
    static func getGetAllTvShowSeasonsEpisodes(tvShowId:Int, requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.VideoLibrary.getTvShowSeasonEpisodes
        
        json[paramsKey] = ["tvshowid" : tvShowId, propertiesKey : [
            "title",
            "plot",
            "rating",
            "runtime",
            "season",
            "episode",
            "file",
            "resume",
            "playcount"]]
        
        
        return json
    }

    static func getGetTvShowEpisodeInfo(tvShowEpisodeId:Int, requestId: UInt32) -> JSON {
        var json = baseJson
        json[requestIdKey].uInt32 = requestId
        json[methodKey].string = ApiAction.VideoLibrary.getTvShowSeasonEpisodeInfo
        
        json[paramsKey] = ["episodeid" : tvShowEpisodeId, propertiesKey : [
            "title",
            "plot",
            "votes",
            "rating",
            "writer",
            "firstaired",
            "playcount",
            "runtime",
            "director",
            "productioncode",
            "season",
            "episode",
            "originaltitle",
            "showtitle",
            "cast",
            "streamdetails",
            "lastplayed",
            "fanart",
            "thumbnail",
            "file",
            "resume",
            "tvshowid",
            "dateadded",
            "uniqueid",
            "art"]]
        
        
        return json
    }
    
}