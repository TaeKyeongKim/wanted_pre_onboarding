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
        print(EndPoint.fetchWeather(for: "Seoul")?.url)
    }

}
