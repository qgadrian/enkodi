//
//  TvShowEpisodeViewController.swift
//  enkodi
//
//  Created by Adrian on 09/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation
import UIKit

class TvShowEpisodeViewController: BaseViewController {
    
    @IBOutlet weak var plotLabel: UILabel!
    
    var baseTvShowEpisode: BaseTvShowEpisode?
    
    override func viewDidLoad() {
        title = baseTvShowEpisode?.title
        plotLabel.text = baseTvShowEpisode?.plot
        plotLabel.sizeToFit()
    }
    
    
}