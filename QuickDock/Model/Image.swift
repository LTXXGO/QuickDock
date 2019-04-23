//
//  Image.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import Foundation

class Image {
    //图片的标题和备注都为可选项，用户可以仅保存图片而不用做其他操作，提高效率
    var titli: String?
    var Remarks: String?
    //默认放置到速览页面
    var enableQuickLook = false
    var quickLookPosition = QuickLookPosition.topLeft
    //提醒选项默认关闭
    var enableRemind = false
    var remindDate = Date()
    
    enum QuickLookPosition {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
}


