//
//  AudioStream.swift
//  enkodi
//
//  Created by Adrian on 19/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class AudioStream: BaseModel {
    
    var index: Int?
    var language: String?
    var name: String?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        index <- map["index"]
        language <- map["language"]
        name <- map["name"]
    }
    
}