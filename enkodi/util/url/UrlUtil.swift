//
//  UrlUtil.swift
//  enkodi
//
//  Created by Adrian on 11/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation

class UrlUtil {
    
    static func parseImageToUrlPath(imageUrl: String) -> String {
        
        let url = imageUrl.stringByReplacingOccurrencesOfString("image://", withString: "/")
        
        return removeLastCharacterOfString(url)
    }
    
    static func removeLastCharacterOfString(string: String) -> String {
        return String(string.characters.dropLast())
    }
    
}