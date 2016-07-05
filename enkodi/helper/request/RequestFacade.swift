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
    
    func sendPlayPause()

    func sendSetVolume(volume: Int)
}