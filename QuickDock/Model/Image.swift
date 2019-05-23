//
//  Image.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import Foundation
import UIKit

// 图片在速览中的位置
enum Position {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

class Image: NSObject, NSCoding {

    var item: UIImage
    var title: String?
    var remark: String?
    
    // 默认放置到速览页面
    var enableQuickLook = true
    var quickLookPosition = Position.topLeft
    
    // 提醒选项默认关闭
    var enableRemind = false
    var remindDate = Date()
    
    // MARK: - Initializers
    init(item: UIImage, title: String?, remark: String?) {
        self.item = item
        self.title = title
        self.remark = remark
    }
    
    // Coder Key
    private enum CoderKeys: String {
        case itemKey
        case titleKey
        case remarkKey
    }
    
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(item, forKey: CoderKeys.itemKey.rawValue)
        aCoder.encode(title, forKey: CoderKeys.titleKey.rawValue)
        aCoder.encode(remark, forKey: CoderKeys.remarkKey.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let decodedItem = aDecoder.decodeObject(forKey: CoderKeys.itemKey.rawValue) as? UIImage else {
            fatalError("图片不存在 / A image did not exist")
        }
        item = decodedItem
        title = aDecoder.decodeObject(forKey: CoderKeys.titleKey.rawValue) as? String
        remark = aDecoder.decodeObject(forKey: CoderKeys.remarkKey.rawValue) as? String
    }
}


