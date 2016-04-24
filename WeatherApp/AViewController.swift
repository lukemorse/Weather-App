//
//  AViewController.swift
//  PageViewControllerSwiftDemo
//
//  Created by Robert Ryan on 3/7/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//

import UIKit
import Foundation

class AViewController: UIViewController, PageDelegate {
    
    var pageNumber: Int = 0
    
    var picDict: Dictionary<String, String> = [
        "clear sky": "sun",
        "few clouds": "cloud",
        "scattered clouds": "cloud",
        "broken clouds": "cloud",
        "shower rain": "cloud rain",
        "rain": "rain",
        "thunderstorm": "lightning rain",
        "snow": "snow"
    ]
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var tempLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Weather().downloadCurrentWeather { (weather: Dictionary<String, AnyObject>) in
            
            if let list: [AnyObject] = weather["list"] as? [AnyObject] {
                if let today: Dictionary<String, AnyObject> = list[0] as? Dictionary<String, AnyObject> {
                    if let main: Dictionary<String, Double> = today["main"] as? Dictionary<String, Double> {
//                        print(main)
                        let tempF = round((main["temp"]! * 9/5 - 459.67) * 10) / 10
                        self.tempLbl.text = "\(tempF)º F"
                    }
                    if let weather: [AnyObject] = today["weather"] as? [AnyObject] {
                        if let weatherDesc: Dictionary<String, AnyObject> = weather[0] as? Dictionary<String, AnyObject> {
                            if let descString: String = weatherDesc["description"] as? String {
                                self.weatherImg.image = UIImage(named: self.picDict[descString]!)
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
    
    
    
}
