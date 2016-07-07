//
//  ApplicationProperties.swift
//  enkodi
//
//  Created by Adrian on 07/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class ApplicationProperties: BaseModel {
 
    var volume: Int?
    var muted: Bool?
    var name: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        volume <- map["volume"]
        muted <- map["muted"]
        name <- map["name"]
    }
    
}
