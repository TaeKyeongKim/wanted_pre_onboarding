//
//  ViewModel.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

class HomeViewModel {

    private let cities = ["Gongju", "gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon",
                  "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju", "ChunCheon"]
    private let networkManager = NetworkManager()
    var cityWeather: [String: Observable<WeatherSummary?>] = [:]

    init() {
        cities.forEach({
            cityWeather.updateValue(Observable<WeatherSummary?>(nil), forKey: $0)
        })
    }

    func fetchWeatherData() {

        for key in cityWeather.keys {
            networkManager.loadWeather(city: key) { [weak self] result in
                switch result {
                case .success(let data):
                    let detail = WeatherDetail(feelsLike: data.main.feelsLike, tempMin: data.main.tempMin, tempMax: data.main.tempMax, pressure: data.main.pressure, wind: data.wind)

                    let summary = WeatherSummary(cityName: data.name, weather: data.weather.first?.weatherDescription ?? "", icon: data.weather.first?.icon ?? "", temperature: data.main.temp, humidity: data.main.humidity, detail: detail)

                    self?.cityWeather[key]?.value = summary

                case .failure(let error):
                    print(error)
                }
            }
        }

    }

}
