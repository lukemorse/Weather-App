//
//  DViewController.swift
//  PageViewControllerSwiftDemo
//
//  Created by Robert Ryan on 3/7/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//

import UIKit

class DViewController: DayViewController {
    
    override func myWeatherRange(list: [AnyObject]) -> Range<Int> {
        return 24...31
    }
    
    override func myDayOffset() -> Int {
        return 3;
    }
    
}
