//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/11.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {



    @IBOutlet weak var cityBtn: UIButton!
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
