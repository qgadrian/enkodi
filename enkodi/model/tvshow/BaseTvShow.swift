//
//  BaseTvShow.swift
//  enkodi
//
//  Created by Adrian on 04/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseTvShow: Mappable {

    var name: String?
    var id: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["label"]
        id <- map["tvshowid"]
    }

}