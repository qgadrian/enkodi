//
//  TvShowSeasonsViewController.swift
//  enkodi
//
//  Created by Adrian on 08/07/16.
//  Copyright © 2016 adrian quintas. All rights reserved.
//

import Foundation

class TvShowSeasonsViewController: BaseViewController {
    
    var tvShow: BaseTvShow?
    
    override func viewDidAppear(animated: Bool) {
        print("its a trap!!!")
        print(tvShow?.name)
    }
    
}