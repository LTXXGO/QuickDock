//
//  SearchViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}
