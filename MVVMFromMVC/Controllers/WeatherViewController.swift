
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

    @IBAction private func didPromptForLocation(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose location", message: nil, preferredStyle: .alert)
        
        
        let submitAction = UIAlertAction(title: "submit", style: .default) { [weak self] _ in
            guard let newLocation = alert.textFields?.first?.text else { return }
            
            self?.viewModel.changeLocation(newLocation)
        }
        
        alert.addAction(submitAction)
        alert.addTextField()
        present(alert, animated: true)
        
    }
}
