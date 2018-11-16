//
//  ForecastViewTableCell.swift
//  DarkSkyGoat
//
//  Created by Adrian Roe on 11/15/18.
//  Copyright © 2018 AdrianRoe. All rights reserved.
//

import Foundation
import UIKit

class ForecastViewTableCell : UITableViewCell{
    @IBOutlet var DayLabel : UILabel?
    @IBOutlet var HighTempLabel :UILabel?
    @IBOutlet var LowTempLabel : UILabel?
 
    func setup(forecastData : DailyForecastData){
        self.DayLabel?.text = forecastData.DayReadable
        self.HighTempLabel?.text = String(forecastData.TemperatureHigh)
        self.LowTempLabel?.text = String(forecastData.TemperatureLow)
    }
}
