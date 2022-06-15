//
//  ViewModel.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

class HomeViewModel {
    let cities = ["Gongju", "gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon",
                  "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju", "ChunCheon"]

    private let networkManager = NetworkManager()
    private var cache = NSCache<NSString, NSData>()
    private var fileManager = FileManager()
    var cityWeather: [String: Observable<WeatherSummary?>] = [:]

    init() {
        cities.forEach({
            self.cityWeather[$0] = Observable<WeatherSummary?>(nil)
        })
    }

    subscript(_ indexPath: IndexPath) -> WeatherSummary? {
        let city = cities[indexPath.item]
        guard let model = cityWeather[city]?.value else {return nil}
        return model
    }

    func fetchWeatherData() {

        for key in cityWeather.keys {
            networkManager.loadWeather(city: key) { [weak self] result in

                switch result {
                case .success(let data):
                    let detail = WeatherDetail(feelsLike: data.main.feelsLike, tempMin: data.main.tempMin, tempMax: data.main.tempMax, pressure: data.main.pressure, wind: data.wind)

                    let summary = WeatherSummary(cityName: data.name, weather: data.weather.first?.weatherDescription ?? "", icon: data.weather.first?.icon ?? "", temperature: data.main.temp, humidity: data.main.humidity, detail: detail)

                    self?.cityWeather[key]?.value = summary

                case .failure:
                    self?.cityWeather[key]?.value = nil
                }
            }
        }
    }

    func fetchIconImage(icon: String?, completion: @escaping (Data) -> Void) {

        guard let icon = icon else {return}
        print(icon)
        if let imageData = cache.object(forKey: icon as NSString) {
            completion(imageData as Data)
            return
        }

        // Disk Cache
//        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
//            return
//        }
//        var filePath = URL(fileURLWithPath: path)
//        filePath.appendPathComponent(icon)
//
//        if !fileManager.fileExists(atPath: filePath.path) {
//            fileManager.createFile(atPath: filePath.path,
//                                   contents: cache.object(forKey: icon as NSString)?.base64EncodedData(),
//                                   attributes: nil)
//        }

        networkManager.fetchImage(icon: icon) { [weak self] result in
            switch result {
            case .success(let data):
                self?.cache.setObject(data as NSData, forKey: icon as NSString)
                completion(data)
                return
            case .failure(let error):
                print(error)
            }
        }
    }

}
