//
//  ForecastViewController.swift
//  DarkSkyGoat
//
//  Created by Adrian Roe on 11/13/18.
//  Copyright © 2018 AdrianRoe. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

//Main view controller that handles location data and displays daily forecast table
class ForecastViewController : UIViewController{
    
    @IBOutlet var tableView : UITableView?
    
    private let locationManager : CLLocationManager = CLLocationManager()
    private let forecastSession : ForecastApiSession = ForecastApiSession()
    
    private var forecasts : [DailyForecastData]?
    
    override func viewDidLoad() {
        self.locationManager.delegate = self
        
        //hiding seperator for empty cell
        self.tableView?.tableFooterView = UIView()
    }
    
    private func getForecast(){
        //get current user location, pass to api session and parse the result
        guard let location = self.locationManager.location else{return}
        self.forecastSession.GetLocationForecast(location: location) { (data) in
            //fail case
            guard let dailyForecastData = data else{
                print("No location forecast from ForecastApiSession")
                return
            }
            self.forecasts = dailyForecastData
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    //On nav bar button
    @IBAction func onGetLocationButton(){
        self.requestLocationPermission()
    }
    //prompt user to give location permission
    private func requestLocationPermission(){        
        self.locationManager.requestWhenInUseAuthorization()
    }
}

extension ForecastViewController : CLLocationManagerDelegate{
    //called when user grants permission or when locationmanager is initialized
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            self.getForecast()            
        }
    }
}

extension ForecastViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableCell", for: indexPath)
        // pass forecast data to table cell
        if let forecastCell = cell as? ForecastViewTableCell,
            let forecastData = self.forecasts?[indexPath.row]{
            forecastCell.setup(forecastData: forecastData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let forecastData = self.forecasts?[indexPath.row],
            let dailyDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DailyDetailViewController") as? DailyDetailViewController else {return}
        //on table cell tap, populate Detail VC and display
        dailyDetailVC.setup(forecastData)
        self.navigationController?.pushViewController(dailyDetailVC, animated: true)
    }
}
