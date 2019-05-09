//
//  SettingTableViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消选中效果的动画
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // MARK: - 备份/恢复数据还没实现
            }
            if indexPath.row == 1 {
                clearData()
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 2 {
                recommendToFriends()
            }
        }
    }
    
    // 使最后一行显示版本号不会有点击动画，不会给用户造成困惑
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 2 {
            return nil
        } else {
            return indexPath
        }
    }
    
    func recommendToFriends() {
        let MessageForShare = ["test message"]
        let activityController = UIActivityViewController(activityItems: MessageForShare, applicationActivities: nil)
        // 以模态方式将一个视图控制器弹出窗口
        present(activityController, animated: true, completion: nil)
    }
    
    func clearData() {
        // 弹出二次确认提示框
        showAlert()
        // MARK: - 删除图片还没实现
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "警告", message: "是否删除全部图片？", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "确定", style: .destructive, handler: nil)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}


