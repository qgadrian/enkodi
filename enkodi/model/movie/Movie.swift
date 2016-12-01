//
//  Movie.swift
//  enkodi
//
//  Created by Adrian on 19/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import ObjectMapper


class BaseMovie: BaseWatchable {
    
    var title: String?
    var genre: String?
    var year: Int?
    var rating: Double?
    var plot: String?
    var tagLine: String?
    var imdbId: Int?
    var country: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        title <- map["title"]
        genre <- map["genre"]
        year <- map["year"]
        rating <- map["rating"]
        plot <- map["plot"]
        tagLine <- map["tagLine"]
        imdbId <- map["imdbnumber"]
        country <- map["country"]
    }
    
}