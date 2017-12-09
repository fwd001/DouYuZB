//
//  UIBaeButtonItem-Extension.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/9.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(image: UIImage, highImage: UIImage, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        btn.setImage(highImage, for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    */
    
    convenience init(image: UIImage, highImage: UIImage?, size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let hightImage1 = highImage {
           btn.setImage(hightImage1, for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        
        self.init(customView: btn)
    }
}
