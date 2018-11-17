//
//  DailyDetailViewController.swift
//  DarkSkyGoat
//
//  Created by Adrian Roe on 11/16/18.
//  Copyright © 2018 AdrianRoe. All rights reserved.
//

import Foundation
import UIKit

//Daily Detail VC displays information for specific day
class DailyDetailViewController : UIViewController{
    @IBOutlet var ForecastImageView : UIImageView?
    @IBOutlet var SummaryLabel : UILabel?
    
    private var forecastData : DailyForecastData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.forecastData?.DayReadable
        self.SummaryLabel?.text = self.forecastData?.Summary
        
        if let forecastIcon = self.forecastData?.Icon{
            self.ForecastImageView?.image = UIImage(forecastIcon: forecastIcon)
        }
    }
    func setup(_ data : DailyForecastData){
        self.forecastData = data
    }
}
