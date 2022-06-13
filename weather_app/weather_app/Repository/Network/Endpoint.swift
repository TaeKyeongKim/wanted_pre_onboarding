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
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/" + path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)"
        )}
        return url
    }

    private static var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "weather_API", ofType: "plist") else {return
            ""}

        let plist = NSDictionary(contentsOfFile: filePath)

        guard let value = plist?.object(forKey: "API_KEY") as? String else {return
            ""}

        return value
    }
}

extension EndPoint {

    static func weather(for city: String) -> Self {

        let apiKey = EndPoint.apiKey

        return EndPoint(path: "weather",
                        queryItems: [URLQueryItem(name: "q", value: "\(city)"),
                                     URLQueryItem(name: "appid", value: "\(apiKey)"),
                                     URLQueryItem(name: "lang", value: "kr"),
                                     URLQueryItem(name: "units", value: "metric")])
    }

}
