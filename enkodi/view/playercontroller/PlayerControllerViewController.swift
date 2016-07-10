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

class PlayerControllerViewController : BaseVolumeViewController {
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Input actions
    @IBAction func homeButtonOnClick(sender: AnyObject) {
        requestFacade!.sendInputAction(InputAction.HOME)
    }
    @IBAction func backButtonOnClick(sender: AnyObject) {
        requestFacade!.sendInputAction(InputAction.BACK)
    }
    @IBAction func upButtonOnClick(sender: AnyObject) {
        requestFacade!.sendInputAction(InputAction.UP)
    }
    @IBAction func downButtonOnClick(sender: AnyObject) {
        requestFacade!.sendInputAction(InputAction.DOWN)
    }
    @IBAction func rightButtonOnClick(sender: AnyObject) {
        if(BaseViewController.isPlayerPlaying()) {
            requestFacade!.sendExecuteAction(ExecutionAction.FORWARD)
        } else {
            requestFacade!.sendInputAction(InputAction.RIGHT)
        }
    }
    @IBAction func leftButtonOnClick(sender: AnyObject) {
        if(BaseViewController.isPlayerPlaying()) {
            requestFacade!.sendExecuteAction(ExecutionAction.BACKWARD)
        } else {
            requestFacade!.sendInputAction(InputAction.LEFT)
        }
    }
    @IBAction func okButtonOnClick(sender: AnyObject) {
        requestFacade!.sendInputAction(InputAction.OK)
    }
    
}
