import UIKit

class CitiesViewController: UIViewController, UITableViewDataSource {
    /*
     강수확률 ~30 -> 맑은화면
     강수확률 30~70 -> 구름낀화면
     강수확률 70~ -> 우산든화면
     
     온도 10도 이하일때는 눈내리는 화면, 온도정보 파란글씨
    */
    
    @IBOutlet weak var tableView: UITableView!
    
    var cities: [City] = []
    var countryName: String = ""
    let cellIdentifier: String = "cityCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //한가지의 섹션만 쓰기때문에, 스태틱 값으로 고정
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //도시명을 불러오고, 테이블 뷰를 갱신함
        self.title = countryName
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: CityTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CityTableViewCell else{
            return CityTableViewCell()
        }
        
        let city: City = self.cities[indexPath.row]
        
        //도시명 불러오기
        cell.cityName?.text = city.name
        
        //온도 불러오기
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        let celsius     = formatter.string(for: city.celsius) ?? "0"
        let fahrenheit  = formatter.string(for: getFahrenheit(city.celsius)) ?? "0"
        
        cell.temperatureInformation?.text = "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
        
        //강수량 불러오기
        let rainfall = formatter.string(for: city.rainfallProbability) ?? "0"
        cell.rainyProbability?.text = "강수확률 : \(rainfall)%"
        
        //10도 이하일때는 파란색 표시
        if city.celsius > 10{
            cell.temperatureInformation.textColor = UIColor.black
        } else {
            cell.temperatureInformation.textColor = UIColor.blue
        }
        //이미지 불러오기
        cell.weatherImage.image = UIImage(named: getImageString(city.celsius, city.rainfallProbability))
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let nextViewController: CityWeatherInformationViewController = segue.destination as? CityWeatherInformationViewController else{
            return
        }
        
        guard let cell: CityTableViewCell = sender as? CityTableViewCell else{
            return
        }
        
        if let cityName = cell.cityName.text {
            nextViewController.cityName = cityName
        }
        if let weatherImage = cell.weatherImage.image {
            nextViewController.weatherImage = weatherImage
        }
        if let temperature = cell.temperatureInformation.text{
            nextViewController.temperatureString = temperature
            nextViewController.labelColor = cell.temperatureInformation.textColor
        }
        if let rainyProbality = cell.rainyProbability.text{
            nextViewController.rainyProbalityString = rainyProbality
        }
        
        var weatherString: String = ""
        
        for city in cities {
            if city.name == cell.cityName.text {
                if city.rainfallProbability < 30 {
                    weatherString = "맑음"
                } else if city.rainfallProbability < 70 {
                    weatherString = "흐림"
                } else {
                    if city.celsius > 10 {
                        weatherString = "비"
                    } else {
                        weatherString = "눈"
                    }
                }
            }
        }
        
        nextViewController.weatherString = weatherString
    }
    
    //화씨로 변환
    func getFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 1.8) + 32
    }
    
    //온도와 강수량에 따른 이미지명 불러오기
    func getImageString(_ celsius: Double, _ rainyProbability: Double) -> String {
        if rainyProbability < 30.0 {
            return "sunny"
        } else if rainyProbability < 70.0 {
            return "cloudy"
        } else {
            if celsius > 10 {
                return "rainy"
            } else{
                return "snowy"
            }
        }
    }
}
