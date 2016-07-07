//
//  TimeUtil.swift
//  enkodi
//
//  Created by Adrian on 07/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation


class TimeUtil {
    
    static func getTimeString(time: Time) -> String {
        let hours = time.hours!
        let minutes = time.minutes!
        let seconds = time.seconds!
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}