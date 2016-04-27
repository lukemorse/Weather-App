//
//  AViewController.swift
//  PageViewControllerSwiftDemo
//
//  Created by Robert Ryan on 3/7/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//

import UIKit

class AViewController: DayViewController {
    
    override func myWeatherRange(list: [AnyObject]) -> Range<Int> {
        return 0...7
    }
    
    override func myDayOffset() -> Int {
        return 0;
    }

}
