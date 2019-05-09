//
//  DJFashionStyleChartsNetTask.swift
//  DejaFashion
//
//  Created by levi duan on 2019/4/22.
//  Copyright © 2019 Mozat. All rights reserved.
//

import UIKit

class DJFashionStyleChartsNetTask: DJHTTPCloudNetTask {
    
    // query
    var regionId : Int?
    
    // response
    var result : DJStyleChartsModel?
    
    override func uri() -> String! {
        return "shop/lookbook/style_charts"
    }
    
    override func method() -> DJHTTPNetTaskMethod {
        return DJHTTPNetTaskGet
    }
    
    override func query() -> [AnyHashable: Any]! {
        
        var dict = Dictionary<String , AnyObject>()

        if let regionId = regionId {
            dict["regin_id"] = regionId as AnyObject
        }
        else {
            return nil
        }
        return dict
    }
    
    override func didResponseJSON(_ response: [AnyHashable : Any]!) {
        if let dict = response["data"] as? NSDictionary {
            result = DJStyleChartsModel.parseItem(dict)
        }
    }
    
    override func didFail(_ error: Error!) {
        print("DJFashionStyleChartsNetTask did fail. Error: ", error.localizedDescription)
    }
}
