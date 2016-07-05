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
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var requestFacade: RequestFacade!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        requestFacade = RequestFacade(requestClass: RequestClass.WEB_SOCKET, socket: socket)
    }
    
    // Input actions
    @IBAction func backButtonOnClick(sender: AnyObject) {
        requestFacade.sendInputAction(InputAction.BACK)
    }
    @IBAction func upButtonOnClick(sender: AnyObject) {
        requestFacade.sendInputAction(InputAction.UP)
    }
    @IBAction func downButtonOnClick(sender: AnyObject) {
        requestFacade.sendInputAction(InputAction.DOWN)
    }
    @IBAction func rightButtonOnClick(sender: AnyObject) {
        requestFacade.sendInputAction(InputAction.RIGHT)
    }
    @IBAction func leftButtonOnClick(sender: AnyObject) {
        requestFacade.sendInputAction(InputAction.LEFT)
    }
    @IBAction func okButtonOnClick(sender: AnyObject) {
        requestFacade.sendInputAction(InputAction.OK)
    }
    
    // Player actions
    @IBAction func playPauseButtonOnClick(sender : AnyObject) {        
        requestFacade.sendPlayPause()
    }
    
    @IBAction func stopButtonOnClick(sender: AnyObject) {
        requestFacade.sendStop()
    }
    
    @IBAction func volumeSliderOnSlide(sender: AnyObject) {
        let volume: Int = Int(volumeSlider.value)
        requestFacade.sendSetVolume(volume)
    }
    
}
