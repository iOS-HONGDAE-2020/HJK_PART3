import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    func getCountryName() -> String{
        if let countryNameString = countryName.text {
            return countryNameString
        } else{
            return ""
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        countryName.text = ""
        countryImage.image = nil
    }
    
}
