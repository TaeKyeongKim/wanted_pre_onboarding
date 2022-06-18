//
//  ViewController.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/13.
//

import UIKit

class HomeViewController: UIViewController {

    private var homeCollectionView: UICollectionView?
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDisplay()
        bindData()

    }

    private func configureDisplay() {
        setView()
        setCollectionView()
        setConstraints()
    }

    private func bindData() {
        viewModel.cityWeather.values.forEach({$0.bind { [weak self] data in
            guard let data = data else {return}
            DispatchQueue.main.async {
                guard let index = self?.viewModel.cities.firstIndex(of: data.cityName) else {return}
                self?.homeCollectionView?.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
        }})
        viewModel.fetchWeatherData()
    }

    private func setView() {
        view.backgroundColor = .secondarySystemBackground
        title = "Weather APP"
    }

    private func setCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CityWeatherCell.self, forCellWithReuseIdentifier: CityWeatherCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondarySystemBackground
        self.homeCollectionView = collectionView
    }

    private func setConstraints() {
        guard let collectionView = homeCollectionView else {return}
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

 extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cityWeather.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityWeatherCell.id, for: indexPath) as? CityWeatherCell else {return UICollectionViewCell()}

        if let model = viewModel[indexPath] {
            ImageCacheManager.shared.fetchIconImage(icon: model.icon) { data in
                DispatchQueue.main.async {
                    cell.configureImage(data)
                }
            }
            cell.configure(model: model)
        }
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: view.frame.width - 16, height: 70)
     }
 }

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCity = viewModel[indexPath] else {return}
        let ChildVC = DetailViewController(weatherData: selectedCity)
        present(ChildVC, animated: true)

    }
}
