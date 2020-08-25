import UIKit

/*
 첫번째 뷰.
 국가들을 나열
 */
class CountriesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier  : String    = "countryCell"
    var countries       : [Country] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !loadCountries(){//시작 시 데이터 불러오기
            print("국가 로드 오류")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CountryTableViewCell else{
            return CountryTableViewCell()
        }
        
        let country: Country = self.countries[indexPath.row]
        
        cell.countryName?.text = country.asset.name
        if let countryImage = country.image{
            cell.countryImage?.image = countryImage
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let nextViewController: CitiesViewController = segue.destination as? CitiesViewController else{
            return
        }
        
        guard let cell: CountryTableViewCell = sender as? CountryTableViewCell else{
            return
        }
        
        //국가 이름 얻기
        nextViewController.countryName = cell.getCountryName()
        
        //국가를 찾은 후 도시 반환
        for country in countries{
            if cell.getCountryName() == country.asset.name{
                nextViewController.cities = country.cities
            }
        }
    }
    
    //제이슨 데이터를 불러오는 과정에서 코드가 길어져 분리함
    func loadCountries() -> Bool{
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else{
            return false
        }
        do{
            let countryAssets = try jsonDecoder.decode([CountryAsset].self, from: dataAsset.data)
            
            //이미지를 넣기 위해, 따로 구조체 사용
            for country in countryAssets{
                self.countries.append(Country(assetName: country))
            }
        } catch{
            print(error.localizedDescription)
            return false
        }
        
        self.tableView.reloadData()
        
        return true
    }
}
