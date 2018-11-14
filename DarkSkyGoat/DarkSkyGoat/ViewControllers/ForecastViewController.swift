//
//  ForecastViewController.swift
//  DarkSkyGoat
//
//  Created by Adrian Roe on 11/13/18.
//  Copyright © 2018 AdrianRoe. All rights reserved.
//

import Foundation
import UIKit

class ForecastViewController : UIViewController{
    
    private var forecastSession : ForecastApiSession = ForecastApiSession()
    
    override func viewDidLoad() {
        self.getForecast()
    }
    
    private func getForecast(){        
        self.forecastSession.GetLocationForecast { (data) in
            guard let dailyForecastData = data else{
                print("No location forecast from ForecastApiSession")
                return
            }
            print("YAY")
        }
    }
}
