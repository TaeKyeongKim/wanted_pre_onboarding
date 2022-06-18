//
//  CityWeatherCell.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/15.
//

import UIKit

final class CityWeatherCell: UICollectionViewCell {

    static let id = "CityWeatherCell"

    private var weatherImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var cityName: UILabel = {
        let label  = UILabel()
        label.font = .smallBold
        return label
    }()

    private var temperature: UILabel = {
        let label = UILabel()
        label.font = .smallRegular

        return label
    }()

    private var humidity: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        return label
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperature, humidity])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var informationContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityName, informationStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDisplay()
        configureConstraints()
    }

    private func configureDisplay() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .white
        contentView.addSubview(weatherImageView)
        contentView.addSubview(informationContainerStackView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.width/1.3),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            informationContainerStackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            informationContainerStackView.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor)
        ])
    }

    func configure(model: WeatherSummary?) {
        guard let model = model else {return}
        cityName.text = "\(model.cityName)"
        temperature.text = "현재기온: \(model.temperature)°C"
        humidity.text = "현재습도: \(model.humidity)%"
    }

    func configureImage(_ data: Data) {
        weatherImageView.image = UIImage(data: data)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
