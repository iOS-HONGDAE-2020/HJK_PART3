import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperatureInformation: UILabel!
    @IBOutlet weak var rainyProbability: UILabel!
    
    //조언에 따른 초기화 함수
    override func prepareForReuse() {
        super.prepareForReuse()
        
        weatherImage.image = nil
        cityName.text = ""
        temperatureInformation.text = ""
        rainyProbability.text = ""
    }
}
