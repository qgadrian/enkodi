//
//  PlayerControllerViewController.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit
import Starscream
import SwiftyJSON
import ObjectMapper

class PlayerControllerViewController : BaseViewController {
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var webSocketHelper: RequestFacade!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        webSocketHelper = WebSocketHelper(socket: socket)
    }
    
    @IBAction func playPauseButtonOnClick(sender : AnyObject) {        
        webSocketHelper.sendPlayPause()
    }
    
    @IBAction func volumeSliderOnSlide(sender: AnyObject) {
        var volume: Int = Int(volumeSlider.value)
        print(volume)
        webSocketHelper.sendSetVolume(volume)
        
    }
    
}
