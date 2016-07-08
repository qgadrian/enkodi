//
//  JsonParseHelper.swift
//  enkodi
//
//  Created by Adrian on 08/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class JsonParseHelper {
    
    static func parseApplicationProperties(json: JSON) -> ApplicationProperties {
        return Mapper<ApplicationProperties>().map(json[JsonHelper.resultKey].object)!
    }
    
    static func parseVolumeChangeNotification(json: JSON) -> VolumeChangeNotification {
        return Mapper<VolumeChangeNotification>().map(json[JsonHelper.paramsKey][JsonHelper.dataKey].object)!
    }
    
}