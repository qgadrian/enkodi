//
//  BaseTvShowEpisode.swift
//  enkodi
//
//  Created by Adrian on 09/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper


class BaseTvShowEpisode: BaseModel {
    
    var id: Int?
    var title: String?
    var plot: String?
    var episodeNumber: Int?
    var file: String?
    var officialTotalTime: Int?
    var seasonNumber: Int?
    var playCount: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["episodeid"]
        title <- map["title"]
        plot <- map["plot"]
        episodeNumber <- map["episode"]
        file <- map["file"]
        officialTotalTime <- map["runtime"]
        seasonNumber <- map["season"]
        playCount <- map["playcount"]
    }
    
    func isWatched() -> Bool {
        return playCount != nil && playCount > 0
    }
}