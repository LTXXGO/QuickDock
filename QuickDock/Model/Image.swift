//
//  Image.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import Foundation
import UIKit

class Image: NSObject, NSCoding {
    // 图片
    var item: UIImage
    
    // 图片的标题和备注都为可选项，用户可以仅保存图片而不用做其他操作，提高效率
    var title: String?//标题
    var remark: String?//备注
    
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
    
    // 图片在速览中的位置
    enum Position {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
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


