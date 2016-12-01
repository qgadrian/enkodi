//
//  BaseTvShowEpisode.swift
//  enkodi
//
//  Created by Adrian on 09/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper


class BaseTvShowEpisode: BaseWatchable {
    
    var id: Int?
    var title: String?
    var plot: String?
    var episodeNumber: Int?
    var seasonNumber: Int?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        id <- map["episodeid"]
        title <- map["title"]
        plot <- map["plot"]
        episodeNumber <- map["episode"]
        seasonNumber <- map["season"]
    }

}