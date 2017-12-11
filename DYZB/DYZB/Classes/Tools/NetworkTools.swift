//
//  NetworkTools.swift
//  DYZB
//
//  Created by 伏文东 on 2017/12/11.
//  Copyright © 2017年 伏文东. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType1 {
    case get
    case post
}

class NetworkTools {
 
    class func requestData(type : MethodType1, URLString : String, parameters : [String: Any]? = nil, finishedCallback : @escaping (_ result: Any) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else { return }
            
            finishedCallback(result)
        }
    }

}

