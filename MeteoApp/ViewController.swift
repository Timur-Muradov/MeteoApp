//
//  ViewController.swift
//  MeteoApp
//
//  Created by Тимур Мурадов on 30.07.2022.
//
import CoreLocation
import UIKit
import Foundation


struct City {
    var name: String
    var latitude: Double
    var longitude: Double
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var locationManager = CLLocationManager()
    
    var coordinate: Coordinate?
    //var cityName: ((String)->Void)?
    
    var cities:[City] = [City(name: "Санкт - Петербург", latitude: 59.9386300, longitude: 30.3141300), City(name: "Минск", latitude: 53.9000000, longitude: 27.5666700), City(name: "Качканар", latitude: 58.7002000, longitude: 59.4839000), City(name: "Мое местоположение", latitude: 0.0, longitude: 0.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        print(city)
        
        if city.name == "Мое местоположение" {
            self.MyPosition()
        }
        else {
            loadData(city: city)
        }
        // cityName(name: city.name)
        // openWeatherScreen()
        
    }
    
    func cityName(name: String)->String {
        return name
    }
    
    func loadData(city: City) {
        
        let URLString = "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&hourly=temperature_2m,rain,windspeed_10m"
        if let url = URL(string: URLString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { response, data, error in
                if let data = data {
                    if let coordinate: Coordinate = try? JSONDecoder().decode(Coordinate.self, from: data) {
                        self.coordinate = coordinate
                        self.tableView.reloadData()
                        
                        self.openWeatherScreen(cityname: city.name)
                    }
                }
            }
        }
    }
    
    func openWeatherScreen(cityname:String) {
        
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc: WeatherScreen = str.instantiateViewController(withIdentifier: "WeatherScreen") as? WeatherScreen {
            vc.coordinate = self.coordinate
            vc.cityname = cityname
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func MyPosition() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.headingFilter = 5.0
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        StartUpdatingLocation()
    }
    
    func StartUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func StopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as? ClassCell {
            let city = cities[indexPath.row]
            cell.Label.text = city.name
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension ViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            let city = City(name: "Мое местоположение", latitude: lat, longitude: lon)
            loadData(city: city)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
}
