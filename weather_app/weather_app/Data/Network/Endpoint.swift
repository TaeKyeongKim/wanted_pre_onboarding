//
//  Endpoint.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/13.
//

import Foundation

struct EndPoint {

    let urlInformation: URLInformation

    init(urlInformation: URLInformation) {
        self.urlInformation = urlInformation
    }

    var url: URL? {
        guard let component = urlInformation.component else {return nil}
        var components = URLComponents()
        components.scheme = component.scheme
        components.host = component.host
        components.path = component.path
        components.queryItems = component.queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)"
            )}
        return url
    }
}
