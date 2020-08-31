////

import Foundation
import UIKit.UIImage

final class WeatherViewModel {
    private let geocoder = LocationGeocoder()
    
    private enum Constants {
        static let defaultAddress = "McGaheysville, VA"
        static let emptyString = ""
    }
    
    static let temp = "ssss"
    // MARK: - Init

    init() {
        changeLocation(Constants.defaultAddress)
    }
    
    // MARK: - Public API
    
    let locationName = Box("Loading...")
    
//    func geocode() {
//
//        geocoder.geocode(addressString: Constants.defaultAddress) { [weak self] locations in
//            guard
//                let self = self,
//                let location = locations.first
//                else {
//                    return
//            }
//            print("-=- 1")
//            self.fetchWeatherForLocation(location)
//        }
//
//    }
    
    func fetchWeatherForLocation(_ location: Location) {
        // 1
        WeatherbitService.weatherDataForLocation(
            latitude: location.latitude,
            longitude: location.longitude
        ) { [weak self] weatherData, _ in
            // 2
            guard
                let self = self,
                let weatherData = weatherData
            else {
                return
            }
            self.date.value = self.dateFormatter.string(from: weatherData.date)
            self.currentIcon.value = UIImage(named: weatherData.iconName)
            let temp = self.tempFormatter.string(from: weatherData.currentTemp as NSNumber) ?? ""
            self.currentSummary.value = "\(weatherData.description) - \(temp)℉"
            self.currentIcon.value = UIImage(named: self.dateFormatter.string(from: weatherData.date))
            self.locationName.value = location.name
        }
        
    }
    
    func changeLocation(_ newLocation: String) {
        locationName.value = "Loading..."
        
        geocoder.geocode(addressString: newLocation) { [weak self] locations in
            guard let self = self else{ return }
            
            guard let validLocation = locations.first else {
                self.locationName.value = "Not found"
                self.date.value = " "
                self.currentIcon.value = nil
                self.currentSummary.value = ""
                self.forecastSummary.value = ""
                return
            }
            
            self.fetchWeatherForLocation(validLocation)
            
        }
    }
    // MARK: - Helpers
    
    let date = Box(Constants.emptyString)
    let currentSummary = Box(Constants.emptyString)
    let forecastSummary = Box(Constants.emptyString)
    let currentIcon: Box<UIImage?> = Box(nil)

    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter
    }()

    private let tempFormatter: NumberFormatter = {
        let tempFormatter = NumberFormatter()
        tempFormatter.numberStyle = .none
        return tempFormatter
    }()
    
}
