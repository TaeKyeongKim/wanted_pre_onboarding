//
//  ViewController.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let na = NetworkManager()
        let cities = ["Gongju", "gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon",
                      "Ulsan", "Iksan", "Jeonju", "Jeju", "City", "Cheonan", "Cheongju", "ChunCheon"]

        cities.forEach({
            na.loadWeather(city: $0) { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }

}
