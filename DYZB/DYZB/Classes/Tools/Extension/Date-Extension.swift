//
//  Date-Extension.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/22.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrectTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return interval.description
    }
}
