// {"korean_name":"한국","asset_name":"kr"},

import Foundation
import UIKit

struct Country{
    let asset   : CountryAsset
    let image   : UIImage?
    var cities  : [City]
    
    //생성자
    init(assetName: CountryAsset){
        //애셋 가져오기
        asset = assetName
        
        //이미지 불러오기
        image = UIImage(named: "flag_" + asset.assetName)
        
        //도시정보 가져오기
        cities = []
        let jsonDecoder: JSONDecoder = JSONDecoder()
        if let dataAsset: NSDataAsset = NSDataAsset(name: asset.assetName) {
            do{
                self.cities = try jsonDecoder.decode([City].self, from: dataAsset.data)
                
            } catch{
                print(error.localizedDescription)
            }
        } else {
            print("도시 정보 로드 오류")
            self.cities = []
        }
    }
}

struct CountryAsset: Codable {
    let name        : String
    let assetName   : String
    
    enum CodingKeys: String, CodingKey {
        case name       = "korean_name"
        case assetName  = "asset_name"
    }
}
