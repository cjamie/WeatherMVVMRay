
import UIKit

class WeatherViewController: UIViewController {
    
    private let viewModel = WeatherViewModel()
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var currentIcon: UIImageView!
    @IBOutlet var currentSummaryLabel: UILabel!
    @IBOutlet var forecastSummary: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.locationName.bind { [weak self] newLocation in
            self?.cityLabel.text = newLocation
        }
        
        viewModel.date.bind { [weak self] date in
            self?.dateLabel.text = date
        }
        
        viewModel.currentIcon.bind { [weak self] image in
            guard let image = image else { return }
            self?.currentIcon.image = image
        }
        
        viewModel.currentSummary.bind { [weak self] summary in
            self?.currentSummaryLabel.text = summary
        }
    
        viewModel.forecastSummary.bind { [weak self] forecast in
            self?.forecastSummary.text = forecast
        }

    }

}
