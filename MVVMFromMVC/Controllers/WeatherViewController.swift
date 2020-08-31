
import UIKit

class WeatherViewController: UIViewController {
    private let geocoder = LocationGeocoder()
    private let defaultAddress = "McGaheysville, VA"
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

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var currentIcon: UIImageView!
    @IBOutlet var currentSummaryLabel: UILabel!
    @IBOutlet var forecastSummary: UITextView!

    override func viewDidLoad() {
        geocoder.geocode(addressString: defaultAddress) { [weak self] locations in
            guard
                let self = self,
                let location = locations.first
            else {
                return
            }
            self.cityLabel.text = location.name
            self.fetchWeatherForLocation(location)
        }
    }

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
            self.dateLabel.text =
                self.dateFormatter.string(from: weatherData.date)
            self.currentIcon.image = UIImage(named: weatherData.iconName)
            let temp = self.tempFormatter.string(
                from: weatherData.currentTemp as NSNumber) ?? ""
            self.currentSummaryLabel.text =
                "\(weatherData.description) - \(temp)℉"
            self.forecastSummary.text = "\nSummary: \(weatherData.description)"
        }
    }
}
