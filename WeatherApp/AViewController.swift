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
    
    @IBOutlet weak var highLbl: UILabel!
    
    @IBOutlet weak var lowLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Weather().downloadCurrentWeather { (weather: Dictionary<String, AnyObject>) in
            
            var tempMax = -1000.0
            var tempMin = 1000.0
            
            if let list: [AnyObject] = weather["list"] as? [AnyObject] {
                
                for x in list[0...7] {
                    if let main = x["main"] as! Dictionary<String, Double>? {
                        
                        //                        FIGURE OUT TEMP MIN
                        if let tempMinTest = main["temp_min"] {
                            if tempMin > tempMinTest {
                                tempMin  = tempMinTest
                                let tempF = round((tempMin * 9/5 - 459.67) * 10) / 10
                                self.lowLbl.text = "Low: " + String(tempF) + "º F"
                            }
                        }
                        
                        
                        //                        FIGURE OUT TEMP MAX
                        if let tempMaxTest = main["temp_max"] {
                            if tempMax < tempMaxTest {
                                tempMax = tempMaxTest
                                let tempF = round((tempMax * 9/5 - 459.67) * 10) / 10
                                self.highLbl.text = "High: " + String(tempF) + "º F"
                            }
                        }
                    }
                }
                
                
                if let currentWeatherAndImage: Dictionary<String, AnyObject> = list[0] as? Dictionary<String, AnyObject> {
                    if let main: Dictionary<String, Double> = currentWeatherAndImage["main"] as? Dictionary<String, Double> {
                        let tempF = round((main["temp"]! * 9/5 - 459.67) * 10) / 10
                        self.tempLbl.text = "\(tempF)º F"
                    }
                    if let weather: [AnyObject] = currentWeatherAndImage["weather"] as? [AnyObject] {
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
