//
//  WeatherScreen.swift
//  MeteoApp
//
//  Created by Тимур Мурадов on 30.07.2022.
//

import Foundation
import UIKit

class WeatherScreen: UIViewController {
    
    var coordinate: Coordinate?
    var cityname: String?
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var city: UILabel!
    @IBOutlet var сelsius: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = UIImage(named: "2")
        
        self.city.text = cityname
        
       if let temperature = coordinate?.hourly.temperature_2m?.first,
          let format = coordinate?.hourly_units.temperature_2m {
           
           self.сelsius.text = "Температура \(temperature), \(format)"
       }
        
    }
}
