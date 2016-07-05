//
//  JsonRequestHelper.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonRequestHelper {
    
    static let baseJson = JSON(["jsonrpc" : "2.0", "id" : 1])
    
    static func getInputActionJson(inputAction: InputAction) -> JSON {
        var json = baseJson
        var inputActionString: String?
        
        switch (inputAction) {
        case InputAction.UP:
            inputActionString = ApiActions.Input.up
        case InputAction.DOWN:
            inputActionString = ApiActions.Input.down
        case InputAction.LEFT:
            inputActionString = ApiActions.Input.left
        case InputAction.RIGHT:
            inputActionString = ApiActions.Input.right
        case InputAction.OK:
            inputActionString = ApiActions.Input.select
        case InputAction.BACK:
            inputActionString = ApiActions.Input.back
        }
        
        json["method"].string = inputActionString
        
        return json
    }
    
    static func getPlayPauseJson() -> JSON {
        var json = baseJson
        json["method"].string = ApiActions.Player.playPause;
        json["params"] = ["playerid" : 1]
        
        return json
    }
    
    static func getStopJson() -> JSON {
        var json = baseJson
        json["method"].string = ApiActions.Player.stop
        json["params"] = ["playerid" : 1]
        
        return json
    }
    
    static func getSetVolumeJson(volume: Int) -> JSON {
        var json = baseJson
        json["method"].string = ApiActions.Application.setVolume
        json["params"] = ["volume" : volume]
        
        return json
    }

    
}