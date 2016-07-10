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
        static let info = "Input.Info"
    }
    
    struct Execution {
        // method
        static let action = "Input.ExecuteAction"
        //params
        static let forward = "stepforward"
        static let backward = "stepback"
    }
    
    struct Player {
        static let playPause = "Player.PlayPause"
        static let stop = "Player.Stop"
        static let getProperties = "Player.GetProperties"
        static let getCurrentlyPlaying = "Player.GetItem"
    }
    
    struct Application {
        static let setVolume = "Application.SetVolume"
        static let getProperties = "Application.GetProperties"
    }
    
    struct VideoLibrary {
        static let getTvShows = "VideoLibrary.GetTVShows"
        static let getTvShowSeasons = "VideoLibrary.GetSeasons"
        static let getTvShowSeasonEpisodes = "VideoLibrary.GetEpisodes"
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
    
    struct Application {
        static let volumeChanged = "Application.OnVolumeChanged"
    }
}