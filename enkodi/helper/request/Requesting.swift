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

protocol Requesting {
    
    func sendRequest(json: JSON)

}

enum InputAction {
    case UP, DOWN, RIGHT, LEFT
    case OK, BACK
}

enum RequestClass {
    case WEB_SOCKET,  REST
}