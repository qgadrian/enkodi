//
//  RequestFacade.swift
//  enkodi
//
//  Created by Adrian on 05/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import Starscream
import SwiftyJSON

protocol RequestFacade {
    
    func sendRequest(json: JSON)
    
    // Basic actions
    func sendInputAction(inputAction: InputAction)
    
    // Player actions
    func sendPlayPause()
    
    func sendStop()

    func sendSetVolume(volume: Int)

}

enum InputAction {
    case UP, DOWN, RIGHT, LEFT
    case OK, BACK
}