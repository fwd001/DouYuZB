//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/22.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var onileBtn: UIButton!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nikeName: UILabel!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            nikeName.text = anchor.nickname
            var onlieStr = ""
            if anchor.online > 10000 {
                onlieStr = "\(Int(anchor.online / 10000))万在线"
            } else{
                onlieStr = "\(anchor.online)在线"
            }
            onileBtn.setTitle(onlieStr, for: .normal)
            let urlStr = URL(string: anchor.vertical_src)
            iconImageView.kf.setImage(with: urlStr)
        }
    }
}
