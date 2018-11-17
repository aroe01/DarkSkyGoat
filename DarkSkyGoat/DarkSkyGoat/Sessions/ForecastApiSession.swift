//
//  ForecastApiSession.swift
//  DarkSkyGoat
//
//  Created by Adrian Roe on 11/13/18.
//  Copyright © 2018 AdrianRoe. All rights reserved.
//

import Foundation
import CoreLocation

//Wrapper for Darksky api calls
class ForecastApiSession : NSObject{
    
    private var sessionTask : URLSessionTask?
    private lazy var session : URLSession =
        {
            return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
    }()
    
    private let rootUrlString : String = "https://api.darksky.net" ///forecast/[key]/[latitude],[longitude]
    private lazy var rootUrl = URL(string: rootUrlString)

    //private key from console, store in info.plist
    private var apiKey : String? =
    {
        return Bundle.main.object(forInfoDictionaryKey: "DarkSkyApiKey") as? String
    }()
    //run session with given url, callback to pass back response
    private func run(withUrl : URL, callback : @escaping ([DailyForecastData]?)->() ){
        //cancel existing session if still active
        sessionTask?.cancel()
        if  var urlComponents = URLComponents(url: withUrl, resolvingAgainstBaseURL: true) {
            
            guard let url = urlComponents.url else { return }
            
            sessionTask = session.dataTask(with: url) { data, response, error in
                defer { self.sessionTask = nil }
                guard let data = data else{return}
                
                var jsonResponse: JSONDictionary?
                
                do {
                    jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                } catch _ as NSError {
                    print("Error from forecast")
                    return
                }
                //pass back result
                callback(self.parseDailyForecast(from: jsonResponse))
            }
            sessionTask?.resume()
        }
    }
    //take in json dicitonary and convert to DailyForecastData
    private func parseDailyForecast(from json: JSONDictionary?) -> [DailyForecastData]?{
        guard let json = json,
        let dailyFullObj = json["daily"] as? JSONDictionary,
        let dailyArray = dailyFullObj["data"] as? [JSONDictionary] else{return nil}
        
        var returnArray : [DailyForecastData] = [DailyForecastData]()
        for dailyObj in dailyArray{
            returnArray.append(DailyForecastData(dailyObj))
        }
        return returnArray
    }
    //take in CLLocation, run forecast session
    func GetLocationForecast(location : CLLocation, callback : @escaping ([DailyForecastData]?)->() ){
        guard let apiKey = self.apiKey else {return}
        
        //get lat, long from location
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        //create URL for forecast with apikey, lat, long
        guard let forecastUrl = URL(string: "/forecast/\(apiKey)/\(latitude),\(longitude)", relativeTo: rootUrl) else {return}
        
        self.run(withUrl: forecastUrl, callback: callback)
    }
    
}

extension ForecastApiSession : URLSessionDelegate{
        
}
