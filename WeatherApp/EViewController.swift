//
//  EViewController.swift
//  PageViewControllerSwiftDemo
//
//  Created by Luke Morse on 4/22/16.
//  Copyright © 2016 Robert Ryan. All rights reserved.
//

import UIKit

class EViewController: DayViewController {
    
    override func myWeatherRange(list: [AnyObject]) -> Range<Int> {
        return 32...(list.count-1)
    }
    
    override func myDayOffset() -> Int {
        return 4;
    }
    
}
