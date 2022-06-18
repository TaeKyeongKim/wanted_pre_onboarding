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
        bindData()
    }

    private func configureDisplay() {
        setDetailView()
    }

    private func setDetailView() {
        detailView = DetailView()
        view = detailView
    }

    private func bindData() {
        viewModel?.specificWeather.bind(listener: { [weak self] model in
            let icon = self?.viewModel?.specificWeather.value?.icon

            ImageCacheManager.shared.fetchIconImage(icon: icon) { data in
                guard let data = data else {return}
                DispatchQueue.main.async {
                    self?.detailView?.configureImage(data: data)
                }
            }

            DispatchQueue.main.async {
                self?.detailView?.configureInformation(model: model)
            }

        })
    }
}
