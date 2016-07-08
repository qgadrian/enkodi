//
//  VolumeChangeNotification.swift
//  enkodi
//
//  Created by Adrian on 08/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class VolumeChangeNotification: BaseModel {
 
    var volume: Int?
    var muted: Bool?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        volume <- map["volume"]
        muted <- map["muted"]
    }
    
}
