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
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
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
        label.textColor = .systemGray3
        return label
    }()

    private var humidity: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .systemGray3
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
        contentView.addSubview(weatherImageView)
        contentView.addSubview(informationContainerStackView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.width/1.4),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            informationContainerStackView.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            informationContainerStackView.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor)
        ])
    }

    func configure(model: WeatherSummary?) {
        guard let model = model else {return}
        cityName.text = "\(model.cityName)"
        temperature.text = "현재기온: \(model.temperature)"
        humidity.text = "현재습도: \(model.humidity)"
    }

    func configureImage(_ data: Data) {
        weatherImageView.image = UIImage(data: data)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
