//
//  TvShowEpisodeInfo.swift
//  enkodi
//
//  Created by Adrian on 09/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class TvShowEpisodeInfo: BaseTvShowEpisode {
    
    var tvShowName: String?
    var rating: Double?
    var firstAired: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        tvShowName <- map["showtitle"]
        rating <- map["rating"]
        firstAired <- map["firstaired"]
    }
    
}
