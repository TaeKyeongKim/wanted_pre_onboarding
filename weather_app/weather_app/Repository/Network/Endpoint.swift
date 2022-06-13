//
//  Endpoint.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/13.
//

import Foundation

struct EndPoint {
    var path: String
    var queryItems: [URLQueryItem]
}

extension EndPoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/" + path
        components.queryItems = queryItems
        guard let url = components.url else {return nil}
        return url
    }

    private static var apiKey: String? {
        guard let filePath = Bundle.main.path(forResource: "weather_API", ofType: "plist") else {return
            nil}

        let plist = NSDictionary(contentsOfFile: filePath)

        guard let value = plist?.object(forKey: "API_KEY") as? String else {return
            nil}

        return value
    }
}
//https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=cc9adc5ce92a3b5e53924dedbc9ca38a&lang=kr&units=metric
extension EndPoint {

    static func fetchWeather(for city: String) -> Self? {

        guard let apiKey = EndPoint.apiKey else {return nil}

        return EndPoint(path: "weather",
                        queryItems: [URLQueryItem(name: "q", value: "\(city)"),
                                     URLQueryItem(name: "appid", value: "\(apiKey)"),
                                     URLQueryItem(name: "lang", value: "kr"),
                                     URLQueryItem(name: "units", value: "metric")])
    }

}
