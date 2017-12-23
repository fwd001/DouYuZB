//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/11.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    
    @IBOutlet weak var roomName: UILabel!
    
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            roomName.text = anchor?.room_name
        }
    }
}
