//
//  entity.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

struct WeatherSummary {
    let cityName: String
    let weather: String
    let icon: String
    let temperature: Double
    let humidity: Int
    let detail: WeatherDetail
}

struct WeatherDetail {
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let wind: Wind
}
