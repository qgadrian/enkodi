//
//  KodiApiActions.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation

struct ApiActions {
    struct Input {
        static let up = "Input.Up"
        static let down = "Input.Down"
        static let right = "Input.Right"
        static let left = "Input.Left"
        static let select = "Input.Select"
        static let back = "Input.Back"
    }
    
    struct Player {
        static let playPause = "Player.PlayPause"
        static let stop = "Player.Stop"
    }
    
    struct Application {
        static let setVolume = "Application.SetVolume"
    }
}