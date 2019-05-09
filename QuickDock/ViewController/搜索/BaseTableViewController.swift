//
//  BaseTableTableViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/5/9.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

// 基类
class BaseTableViewController: UITableViewController {

    var filteredImages = [Image]()
    
    static let tableViewCellIdentifier = "cellID"
    private static let nibName = "TableCell"
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: BaseTableViewController.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: BaseTableViewController.tableViewCellIdentifier)
    }
    
    // MARK: - Configuration
    func configureCell(_ cell: UITableViewCell, forImage image: Image) {
        
    }
}
