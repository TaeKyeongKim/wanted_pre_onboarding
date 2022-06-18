//
//  ViewModel.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

class HomeViewModel {

    let cities = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan City", "Seoul", "Sokcho", "Suwon", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju", "ChunCheon"]
    private var cache = NSCache<NSString, NSData>()
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
            let endPoint = EndPoint(urlInformation: .weather(city: key))

            NetworkManager.request(endPoint: endPoint) { [weak self] (response: Result<WeatherDTO, NetworkError>) in
                switch response {
                case .success(let data):
                    let detail = WeatherDetail(feelsLike: data.main.feelsLike, tempMin: data.main.tempMin, tempMax: data.main.tempMax, pressure: data.main.pressure, wind: data.wind)

                    let summary = WeatherSummary(cityName: data.name, weather: data.weather.first?.weatherDescription ?? "", icon: data.weather.first?.icon ?? "", temperature: data.main.temp, humidity: data.main.humidity, detail: detail)

                    self?.cityWeather[key]?.value = summary

                case .failure(let error):
                    print(error)
                    self?.cityWeather[key]?.value = nil
                }
            }
        }
    }

    func fetchIconImage(icon: String?, completion: @escaping (Data) -> Void) {

        guard let icon = icon else {return}

        if let imageData = cache.object(forKey: icon as NSString) {
            completion(imageData as Data)
            return
        }

        let endPoint = EndPoint(urlInformation: .image(name: icon))

        NetworkManager.request(endPoint: endPoint) { [weak self] (response: Result<Data, NetworkError>) in
            switch response {
            case .success(let data):
                self?.cache.setObject(data as NSData, forKey: icon as NSString)
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }

}
