//
//  DJStyleChartsModel.swift
//  DejaFashion
//
//  Created by levi duan on 2019/4/22.
//  Copyright © 2019 Mozat. All rights reserved.
//

import UIKit

class DJStyleChartsModel: NSObject {
    var fashionRegionsList: [DJRegionsModel]?
    var fashionStyleChartsList: [DJStyleChartsStreetSnaps]?
}

extension DJStyleChartsModel {
    class func parseItem(_ dic : NSDictionary) -> DJStyleChartsModel {
        let model = DJStyleChartsModel()
        
        if let fashionRegionsList = dic["regions"] as? NSArray {
            model.fashionRegionsList = DJRegionsModel.parses(array: fashionRegionsList)
        }
        
        if let fashionStyleChartsList = dic["streetSnaps"] as? NSArray {
            model.fashionStyleChartsList = DJStyleChartsStreetSnaps.parses(array: fashionStyleChartsList)
        }
        
        return model
    }
}
