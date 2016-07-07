//
//  KodiApiActions.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation

struct ApiAction {
    struct Input {
        static let up = "Input.Up"
        static let down = "Input.Down"
        static let right = "Input.Right"
        static let left = "Input.Left"
        static let select = "Input.Select"
        static let back = "Input.Back"
        static let home = "Input.Home"
    }
    
    struct Player {
        static let playPause = "Player.PlayPause"
        static let stop = "Player.Stop"
        static let getProperties = "Player.GetProperties"
    }
    
    struct Application {
        static let setVolume = "Application.SetVolume"
        static let getProperties = "Application.GetProperties"
    }
    
    struct VideoLibrary {
        static let getTvShows = "VideoLibrary.GetTVShows"
    }
}

//Notifications
struct ApiNotification {
    struct Player {
        static let play = "Player.OnPlay"
        static let pause = "Player.OnPause"
        static let stop = "Player.OnStop"
        static let properties = "Player.OnGetProperties"
    }
    
    struct VideoLibrary {
        static let tvShows = "VideoLibrary.GetTVShows"
    }
}