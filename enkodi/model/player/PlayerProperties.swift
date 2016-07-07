//
//  PlayerProperties.swift
//  enkodi
//
//  Created by Adrian on 06/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class PlayerProperties: BaseModel {
    
    var percentage: Float?
    var currentTime: Time?
    var totalTime: Time?
    var speed: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        percentage <- map["percentage"]
        currentTime <- map["time"]
        totalTime <- map["totaltime"]
        speed <- map["speed"]
    }
    
}

struct Time: Mappable {
    var hours: Int?
    var minutes: Int?
    var seconds: Int?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        hours     <- map["hours"]
        minutes  <- map["minutes"]
        seconds  <- map["seconds"]
    }
}