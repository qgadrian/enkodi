//
//  BaseWatchable.swift
//  enkodi
//
//  Created by Adrian on 19/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseWatchable: BaseModel {
    
    var playCount: Int?
    var file: String?
    var officialTotalTime: Int?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        playCount <- map["playcount"]
        file <- map["file"]
        officialTotalTime <- map["runtime"]
    }
    
    func isWatched() -> Bool {
        return playCount != nil && playCount > 0
    }
}