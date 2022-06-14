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
        view.backgroundColor = .blue
        configureDisplay()
        bindData()

    }

    private func configureDisplay() {
        setCollectionView()
        setConstraints()
    }

    private func bindData() {
        viewModel.fetchWeatherData()
        viewModel.cityWeather.values.forEach({$0.bind { _ in
            // print(data)
        }})
    }

    private func setCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }

    private func setConstraints() {
        guard let collectionView = collectionView else {return}
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    

}
