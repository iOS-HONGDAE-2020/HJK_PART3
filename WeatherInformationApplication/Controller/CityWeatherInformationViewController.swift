import UIKit

class CityWeatherInformationViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainyProbalityLabel: UILabel!
    
    var weatherImage            : UIImage?
    var weatherString           : String = ""
    var temperatureString       : String = ""
    var rainyProbalityString    : String = ""
    var cityName                : String = ""
    var labelColor              : UIColor = UIColor.black
    
    override func viewWillAppear(_ animated: Bool) {
        self.title                  = cityName
        weatherImageView.image      = weatherImage
        temperatureLabel.text       = temperatureString
        temperatureLabel.textColor  = labelColor
        rainyProbalityLabel.text    = rainyProbalityString
        weatherLabel.text           = weatherString
        
    }
    
}
