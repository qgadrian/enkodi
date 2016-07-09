//
//  PlayingDetails.swift
//  enkodi
//
//  Created by Adrian on 09/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper

class PlayingDetails: BaseModel {
    
    private let movieType = "movie"
    private let episodeType = "episode"
    private let musicType = "music"
    
    var title: String?
    var subtitle: String?
    var extraInfo: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["label"]
        
        if map["type"].value() == movieType {
            subtitle <- map["year"]
            extraInfo = ""
        }
        
        if map["type"].value() == episodeType {
            subtitle <- map["showtitle"]
            extraInfo <- map["season"]
        }
        
        if map["type"].value() == musicType {
            subtitle <- map["artist"]
            extraInfo <- map["disc"]
        }
    }
    
}