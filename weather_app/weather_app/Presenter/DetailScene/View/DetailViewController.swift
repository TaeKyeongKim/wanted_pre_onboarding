//
//  DetailViewController.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/17.
//

import UIKit

class DetailViewController: UIViewController {

    private var viewModel: DetailViewModel?
    private var detailView: DetailView?

    init(weatherData: WeatherSummary) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = DetailViewModel(data: weatherData)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDisplay()
    }

    private func configureDisplay() {
        setDetailView()
    }

    private func setDetailView() {
        detailView = DetailView()
        view = detailView
    }

}
