//
//  TvShowSeason.swift
//  enkodi
//
//  Created by Adrian on 09/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class TvShowSeason: BaseModel {
    
    var id: Int?
    var name: String?
    var seasonNumber: Int?
    var totalEpisodes: Int?
    var watchedEpisodes: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["seasonid"]
        name <- map["label"]
        seasonNumber <- map["season"]
        totalEpisodes <- map["episode"]
        watchedEpisodes <- map["watchedepisodes"]
    }
    
}