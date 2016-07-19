//
//  ThemeManager.swift
//  enkodi
//
//  Created by Adrian on 14/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation

struct ThemeManager {
    
    static let SELECTED_THEME_KEY = "SelectedTheme"
    
    static func currentTheme() -> Theme {
        if let storedTheme = NSUserDefaults.standardUserDefaults().valueForKey(SELECTED_THEME_KEY)?.integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .Default
        }
    }
    
}