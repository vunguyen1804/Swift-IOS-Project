//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

enum Temperature{
    case celcius
    case fahrenheit
}

class WeatherViewController: UIViewController, CLLocationManagerDelegate, SendCityNameDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "74fe6b6a084ae9a9bffee662f6b3523c"
    let weatherDataModel : WeatherDataModel =  WeatherDataModel()
    
    //Variables:
    var temperatureMode : Temperature = .fahrenheit
    var temperatureIcon : String = "℉"
    @IBOutlet weak var tempMode: UISwitch!
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //locationManager will run on the background until it got accuracy location.
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func changeTempuratureMode(_ sender: Any) {
        if (tempMode.isOn){
            temperatureMode = .fahrenheit
            temperatureIcon = "℉"
            weatherDataModel.temperature = Int ( Double(weatherDataModel.temperature) * 9/5 + 34 )
        }else {
            temperatureMode = .celcius
            temperatureIcon = "℃"
            weatherDataModel.temperature = Int ( (Double(weatherDataModel.temperature)  - 32 ) * 5/9 )
        }
        updateTempurature()
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData (url : String , parametters : [String : String]){
        Alamofire.request(url, method: .get, parameters: parametters).responseJSON{
            response in
            if response.result.isSuccess {
                let weatherJSON = JSON (response.result.value!)
                print(weatherJSON)
                self.updateWeatherData ( weatherData : weatherJSON )
            }else{
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }

    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData ( weatherData :  JSON ){
        if let temperature = weatherData["main"]["temp"].double {
            if (temperatureMode == .fahrenheit) {
                weatherDataModel.temperature = Int ( temperature * 1.8 - 459.67 )
            }else{
                weatherDataModel.temperature = Int ( temperature  - 273.15 )
            }
            weatherDataModel.city =   weatherData ["name"].string!
            weatherDataModel.condition =  weatherData["weather"][0]["id"].intValue
            weatherDataModel.weatherIcon = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUI()
        }else{
            self.cityLabel.text = "API Issues"
        }
    }

    //Write the updateUIWithWeatherData method here:
    func updateUI (){
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIcon)
        temperatureLabel.text = String(weatherDataModel.temperature) + temperatureIcon
        cityLabel.text = weatherDataModel.city
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        print ("did update")
        //when locationManager got the accuracy location.
        if location.horizontalAccuracy  > 0 {
            locationManager.stopUpdatingLocation()
            print("longitube: \(location.coordinate.longitude) - latitube: \(location.coordinate.latitude) )")
            let lon = String(location.coordinate.longitude)
            let lat = String(location.coordinate.latitude)
            let para : [String: String] = ["lat" : lat , "lon" : lon , "appid" : APP_ID]
            getWeatherData (url : WEATHER_URL , parametters : para)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }

    //MARK: - Change City Delegate methods
    /***************************************************************/

    //Write the userEnteredANewCityName Delegate method here:
    func sendCityName(cityName: String) {
        let param = ["q": cityName , "appid" : APP_ID]
        getWeatherData (url : WEATHER_URL , parametters : param)
    }
    

    
    //Write the PrepareForSegue Method here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
    
    //Update tempurature after changing mode
    func updateTempurature(){
        temperatureLabel.text = String(weatherDataModel.temperature) + temperatureIcon
    }
}


