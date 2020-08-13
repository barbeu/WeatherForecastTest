//
//  WeatherAPIWorker.swift
//  WeatherTest
//
//  Created by Eugeniy on 13.08.2020.
//  Copyright © 2020 Eugeniy. All rights reserved.
//

import Foundation
import Alamofire

final class WeatherAPIWorker {
    private let apiKey = "d7f18797fbe37af1a937064301cf480d"
    
    public static var shared: WeatherAPIWorker {
        return WeatherAPIWorker()
    }
    
    private init() {}
    
    func getForecastAround(lat: Double, lng: Double, count: Int = 20, completion: @escaping (_ error: Error?, _ result: ForecastList?) -> Void) {
        let path = "https://api.openweathermap.org/data/2.5/find"
        let parameters: [String: Any] = [
            "lat": lat,
            "lon": lng,
            "appid": apiKey,
            "lang": "ru",
            "units": "metric",
            "cnt": count
        ]
        
        print("DATA RESPONSE: ", lat, lng)
        
        AF.request(path, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
                case .success:
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let data = response.data {
                        do {
                            let results = try (decoder.decode(ForecastList.self, from: data))
                            completion(nil, results)
                            //                return results
                        } catch {
                            print("ERROR:", error.localizedDescription)
                            completion(error, nil)
                            //                return nil
                        }
                    }
                case .failure(let err):
                    completion(err, nil)
            }
        }
    }    
}

