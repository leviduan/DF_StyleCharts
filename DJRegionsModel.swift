//
//  DJRegionsModel.swift
//  DejaFashion
//
//  Created by levi duan on 2019/4/22.
//  Copyright © 2019 Mozat. All rights reserved.
//

import UIKit

class DJRegionsModel: NSObject {
    var regionsId : Int = 0
    var name : String?
    var isDefault : Bool?
}

extension DJRegionsModel {
    class func parseItem(_ dic : NSDictionary) -> DJRegionsModel {
        let regionsModel = DJRegionsModel()
        
        if let name = dic["name"] as? String {
            regionsModel.name = name
        }
        
        if let regionsId = dic["id"] as? Int {
            regionsModel.regionsId = regionsId
        }
        
        if let isDefault = dic["isDefault"] as? Bool {
            regionsModel.isDefault = isDefault
        }
        
        return regionsModel
    }
    
    class func parses(array: NSArray) -> [DJRegionsModel] {
        var list = [DJRegionsModel]()
        
        for obj in array {
            if let dict = obj as? NSDictionary {
                list.append(DJRegionsModel.parseItem(dict))
            }
        }
        return list
    }
}
