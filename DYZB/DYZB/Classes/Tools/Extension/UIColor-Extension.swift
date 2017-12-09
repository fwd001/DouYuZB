//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/9.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat ,b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
