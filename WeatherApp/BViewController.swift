//
//  BViewController.swift
//  PageViewControllerSwiftDemo
//
//  Created by Robert Ryan on 3/7/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//

import UIKit

class BViewController: UIViewController, PageDelegate {
    
    var pageNumber: Int = 0
    
    var picDict: Dictionary<String, String> = [
        "clear sky": "sun",
        "few clouds": "cloud",
        "scattered clouds": "cloud",
        "broken clouds": "cloud",
        "shower rain": "cloud rain",
        "rain": "rain",
        "light rain": "rain",
        "thunderstorm": "lightning rain",
        "snow": "snow"
    ]
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var highLbl: UILabel!
    
    @IBOutlet weak var lowLbl: UILabel!
    
    func myWeatherRange(list: [AnyObject]) -> Range<Int> {
        return 8...15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Weather().downloadCurrentWeather { (weather: Dictionary<String, AnyObject>) in
            
            var tempMax = -1000.0
            var tempMin = 1000.0
            
            if let list: [AnyObject] = weather["list"] as? [AnyObject] {
                
                for x in list[self.myWeatherRange(list)] {
                    if let main = x["main"] as! Dictionary<String, Double>? {
                        
                        //                        FIGURE OUT TEMP MIN
                        if let tempMinTest = main["temp_min"] {
                            if tempMin > tempMinTest {
                                tempMin = tempMinTest
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
                
                
                if let tomorrowWeather: Dictionary<String, AnyObject> = list[8] as? Dictionary<String, AnyObject> {
                    
                    if let weather: [AnyObject] = tomorrowWeather["weather"] as? [AnyObject] {
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
