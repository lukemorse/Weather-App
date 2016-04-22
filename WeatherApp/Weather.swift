//
//  Weather.swift
//  WeatherAppTest
//
//  Created by Luke Morse on 4/21/16.
//  Copyright © 2016 Luke Morse. All rights reserved.
//

import Foundation
import Alamofire

class Weather {

    func downloadCurrentWeather(completed: DownloadComplete) {
        let url = NSURL(string: WEATHER_URL)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
            print(dict)
            }
        }
        completed()
    }
}