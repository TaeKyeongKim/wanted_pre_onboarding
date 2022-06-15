//
//  ViewController.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/13.
//

import UIKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView?
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
        viewModel.fetchWeatherData()
        viewModel.cityWeather.values.forEach({$0.bind { _ in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }})
    }

    private func setView() {
        view.backgroundColor = .white
        title = "Weather APP"
    }

    private func setCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView =  UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CityWeatherCell.self, forCellWithReuseIdentifier: CityWeatherCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView = collectionView
    }

    private func setConstraints() {
        guard let collectionView = collectionView else {return}
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

 extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cityWeather.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityWeatherCell.id, for: indexPath) as? CityWeatherCell else {return UICollectionViewCell()}

        let model = viewModel.cityWeather[viewModel.cities[indexPath.item]]?.value
        print(model?.icon)
        viewModel.fetchIconImage(icon: model?.icon ?? "00")

        cell.configure(model: viewModel.cityWeather[viewModel.cities[indexPath.item]]?.value)
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: view.frame.width, height: 70)
     }
 }
