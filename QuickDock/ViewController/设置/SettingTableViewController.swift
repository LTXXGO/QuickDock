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
        if section == 0 {
            return 2
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消选中效果的动画
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            if indexPath.row == 2 {
                recommendToFriends()
            }
        }
    }
    
    //使最后一行显示版本号不会有点击动画，不会给用户造成困惑
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 2 {
            return nil
        } else {
            return indexPath
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func recommendToFriends() {
        let MessageForShare = ["test message"]
        let activityController = UIActivityViewController(activityItems: MessageForShare, applicationActivities: nil)
        //以模态方式将一个视图控制器弹出窗口
        present(activityController, animated: true, completion: nil)
    }
    
    //Cancel按钮还没实现，现在无法返回。
    //应该实现:
        //从速览进入设置时，左上角返回按钮应显示 " < 速览 "
        //从全部进入设置时，左上角返回按钮应显示 " < 全部 "
    
}


