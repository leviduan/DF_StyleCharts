//
//  DJStyleChartsStreetSnaps.swift
//  DejaFashion
//
//  Created by levi duan on 2019/4/22.
//  Copyright © 2019 Mozat. All rights reserved.
//

import UIKit

class DJStyleChartsStreetSnaps: NSObject {
    var snapId : Int = 0
    var likeCount : String = ""
    var image : DJStyleChartsStreetSnapsImageModel?
    var fashionIcon : DJStyleChartsFashionIconModel?
}

extension DJStyleChartsStreetSnaps {
    class func parseItem(_ dic : NSDictionary) -> DJStyleChartsStreetSnaps {
        let streetSnapsModel = DJStyleChartsStreetSnaps()
        
        if let likeCount = dic["like_count"] as? String {
            streetSnapsModel.likeCount = likeCount
        }
        
        if let snapId = dic["id"] as? Int {
            streetSnapsModel.snapId = snapId
        }
        
        if let image = dic["image"] as? NSDictionary {
            streetSnapsModel.image = DJStyleChartsStreetSnapsImageModel.parseImage(image)
        }
        
        if let fashionIcon = dic["fashion_icon"] as? NSDictionary {
            streetSnapsModel.fashionIcon = DJStyleChartsFashionIconModel.parseImage(fashionIcon)
        }
        
        return streetSnapsModel
    }
    
    class func parses(array: NSArray) -> [DJStyleChartsStreetSnaps] {
        var list = [DJStyleChartsStreetSnaps]()
        
        for obj in array {
            if let dict = obj as? NSDictionary {
                list.append(DJStyleChartsStreetSnaps.parseItem(dict))
            }
        }
        return list
    }
}

class DJStyleChartsStreetSnapsImageModel : NSObject
{
    var imageUrl : String?
    
    class func parseImage(_ dict: NSDictionary) -> DJStyleChartsStreetSnapsImageModel {
        let streetSnapsImageModel = DJStyleChartsStreetSnapsImageModel()
        if let url = dict["image_url"] as? String {
            streetSnapsImageModel.imageUrl = url
        }
        return streetSnapsImageModel
    }
}

class DJStyleChartsFashionIconModel : NSObject
{
    var accountId : Int?
    
    class func parseImage(_ dict: NSDictionary) -> DJStyleChartsFashionIconModel {
        let model = DJStyleChartsFashionIconModel()
        if let accountId = dict["account_id"] as? Int {
            model.accountId = accountId
        }
        return model
    }
}
