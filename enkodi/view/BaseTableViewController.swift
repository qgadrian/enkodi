//
//  BaseTableViewController.swift
//  enkodi
//
//  Created by Adrian on 10/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: BaseViewController {
    
    func setCellSelectedBackground(cell: UITableViewCell) {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIAppColor.buildUIColor(UIAppColor.selectedCellBackgroundColor)
        cell.selectedBackgroundView = bgColorView
    }
    
}