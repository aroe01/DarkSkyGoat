//
//  DailyForecastData.swift
//  DarkSkyGoat
//
//  Created by Adrian Roe on 11/13/18.
//  Copyright © 2018 AdrianRoe. All rights reserved.
//

import Foundation

/*time: 1542096000,
 summary: "Partly cloudy throughout the day.",
 icon: "partly-cloudy-day",
 sunriseTime: 1542120580,
 sunsetTime: 1542157270,
 moonPhase: 0.2,
 precipIntensity: 0,
 precipIntensityMax: 0.0002,
 precipIntensityMaxTime: 1542132000,
 precipProbability: 0,
 temperatureHigh: 63.1,
 temperatureHighTime: 1542150000,
 temperatureLow: 50.24,
 temperatureLowTime: 1542207600,
 apparentTemperatureHigh: 63.1,
 apparentTemperatureHighTime: 1542150000,
 apparentTemperatureLow: 50.24,
 apparentTemperatureLowTime: 1542207600,
 dewPoint: 28.41,
 humidity: 0.34,
 pressure: 1028.61,
 windSpeed: 2.69,
 windGust: 8.71,
 windGustTime: 1542128400,
 windBearing: 40,
 cloudCover: 0.5,
 uvIndex: 3,
 uvIndexTime: 1542135600,
 visibility: 3.83,
 ozone: 270.51,
 temperatureMin: 51.8,
 temperatureMinTime: 1542117600,
 temperatureMax: 63.1,
 temperatureMaxTime: 1542150000,
 apparentTemperatureMin: 51.8,
 apparentTemperatureMinTime: 1542117600,
 apparentTemperatureMax: 63.1,
 apparentTemperatureMaxTime: 1542150000*/

//Model representing daily forecast data
struct DailyForecastData {
    var Time : TimeInterval
    var TemperatureHigh : Double
    var TemperatureLow : Double
    var Summary : String
    
    var TimeAsDate : Date
    var DayReadable : String
    var Icon : ForecastIcon
    
    init(_ json : JSONDictionary){
        self.Time = json["time"] as? TimeInterval ?? 0
        self.TemperatureHigh = json["temperatureHigh"] as? Double ?? 0
        self.TemperatureLow = json["temperatureLow"] as? Double ?? 0
        self.Summary = json["summary"] as? String ?? ""
        self.TimeAsDate = Date(timeIntervalSince1970: self.Time)
        
        //parse time and save day of the week as string
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE"
        self.DayReadable = dateFormatter.string(from: self.TimeAsDate)
        
        //save forecast icon
        if let iconString = json["icon"] as? String,
            let icon = ForecastIcon(rawValue: iconString){
            self.Icon = icon
        }else{
            self.Icon = .cloudy
            print("FAIL loading forecast icon")
        }
    }
}
