//
//  Subtitles.swift
//  enkodi
//
//  Created by Adrian on 18/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class Subtitles: BaseModel {
    
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