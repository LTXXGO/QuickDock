//
//  Image.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import Foundation
import UIKit

class Image {
    //图片
    var item: UIImage?
    //图片的标题和备注都为可选项，用户可以仅保存图片而不用做其他操作，提高效率
    var titli: String?//标题
    var remark: String?//备注
    //默认放置到速览页面
    var enableQuickLook = true
    var quickLookPosition = Position.topLeft
    //提醒选项默认关闭
    var enableRemind = false
    var remindDate = Date()
    
    //图片在速览中的位置
    enum Position {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
}


