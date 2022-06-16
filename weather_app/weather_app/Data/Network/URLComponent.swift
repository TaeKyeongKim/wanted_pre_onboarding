//
//  URLComponent.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/17.
//

import Foundation

struct URLComponent {
    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]?
}

enum URLInformation {
    case image(name: String)
    case weather(city: String)

    var component: URLComponent? {
        switch self {
        case .image(let name):
            return URLComponent(scheme: "http", host: "openweathermap.org", path: "/img/wn/\(name)@2x.png", queryItems: nil)

        case .weather(let city):
            guard let apiKey = Bundle.searchObject(from: "weather_API", key: "API_KEY") else {return nil}
            let queryItems = [URLQueryItem(name: "q", value: "\(city)"),
                              URLQueryItem(name: "appid", value: "\(apiKey)"),
                              URLQueryItem(name: "lang", value: "kr"),
                              URLQueryItem(name: "units", value: "metric")]
            return URLComponent(scheme: "https", host: "api.openweathermap.org", path: "/data/2.5/weather", queryItems: queryItems)
        }
    }
}
