//
//  AddNewImageTableViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/27.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

class AddNewImageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else if indexPath.section == 4 {
            return 140
        } else {
            return 44
        }
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }

}
