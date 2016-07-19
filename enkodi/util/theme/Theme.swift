//
//  Theme.swift
//  enkodi
//
//  Created by Adrian on 14/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit

enum Theme: Int {
    case Default, Dark, Light
    
    private static let selectedCellBackgroundColor = "#EF5350"
    private static let itemHighlightColor = "#EF5350"
    private static let cellAccesoryTypeColor = "#0277BD"
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .Light:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }
    
    var cellHighlightColor: UIColor {
        switch self {
        case .Default, .Light:
            return UIAppColor.buildUIColor(Theme.selectedCellBackgroundColor)
        case .Dark:
            return UIAppColor.buildUIColor(Theme.selectedCellBackgroundColor)
        }
    }
    
    var itemHighlightColor: UIColor {
        switch self {
        case .Default, .Light:
            return UIAppColor.buildUIColor(Theme.itemHighlightColor)
        case .Dark:
            return UIAppColor.buildUIColor(Theme.itemHighlightColor)
        }
    }
    
    var cellAccesoryColor: UIColor {
        switch self {
        case .Default, .Light:
            return UIAppColor.buildUIColor(Theme.cellAccesoryTypeColor)
        case .Dark:
            return UIAppColor.buildUIColor(Theme.cellAccesoryTypeColor)
        }
    }
}