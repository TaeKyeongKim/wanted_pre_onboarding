//
//  DetailViewModel.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/17.
//

import Foundation

class DetailViewModel {

    let specificWeather = Observable<WeatherSummary?>(nil)

    init(data: WeatherSummary) {
        self.specificWeather.value = data
    }

}
