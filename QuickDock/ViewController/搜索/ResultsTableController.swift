//
//  ResultsTableControllerViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/5/9.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

class ResultsTableController: BaseTableViewController {
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.tableViewCellIdentifier, for: indexPath)
        let image = filteredImages[indexPath.row]
        configureCell(cell, forImage: image)
        return cell
    }
}
