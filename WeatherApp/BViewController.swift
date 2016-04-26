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
    
    @IBOutlet weak var dateLbl: UILabel!

    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var highLbl: UILabel!
    
    @IBOutlet weak var lowLbl: UILabel!
    
    func myWeatherRange(list: [AnyObject]) -> Range<Int> {
        return 8...15
    }
    
    func myDayOffset() -> Int {
        return 1;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDay()
        
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
                
                
                let firstIndexThisDay = self.myWeatherRange(list).startIndex
                if let tomorrowWeather: Dictionary<String, AnyObject> = list[firstIndexThisDay] as? Dictionary<String,  AnyObject> {
                    if (self.tempLbl != nil) {
                        if let main: Dictionary<String, Double> = tomorrowWeather["main"] as? Dictionary<String, Double> {
                            let tempF = round((main["temp"]! * 9/5 - 459.67) * 10) / 10
                            self.tempLbl.text = "\(tempF)º F"
                        }
                    }

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

    func getDay() {
        if (dateLbl != nil) {
            let today = NSDate()
            let day = NSDate(timeInterval: 60 * 60 * 24 * Double(myDayOffset()), sinceDate: today)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
            let convertedDate = dateFormatter.stringFromDate(day)
            dateLbl.text = "\(convertedDate)"
        }
    }
}
