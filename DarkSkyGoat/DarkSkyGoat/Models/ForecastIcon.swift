//
//  ForecastIcon.swift
//  DarkSkyGoat
//
//  Created by Adrian Roe on 11/16/18.
//  Copyright © 2018 AdrianRoe. All rights reserved.
//

import Foundation
import UIKit
/*icon
 clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
 */
//Enum of all possible forecast items
enum ForecastIcon : String{
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain
    case snow
    case sleet
    case wind
    case fog
    case cloudy
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}

//convenience initializer to create UIImage from enum
extension UIImage{
    convenience init(forecastIcon : ForecastIcon) {
        self.init(named: forecastIcon.rawValue)!
    }
}
