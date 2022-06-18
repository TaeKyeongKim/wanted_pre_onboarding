//
//  InformationCell.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/18.
//

import UIKit

final class DetailView: UIView {

    // MARK: Banner = 이미지, 도시이름, 날씨설명, 현재온도
    private var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "multiply")
        imageView.contentMode = .scaleToFill
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var cityNameLabel: UILabel = {
       let label = UILabel()
       label.font = .largeBold
       label.text = "test"
       return label
    }()

    private var weatherDescriptionLabel: UILabel = {
       let label = UILabel()
       label.font = .mediumRegular
       label.text = "test"
       return label
    }()

    private var currentTemperatureLabel: UILabel = {
       let label = UILabel()
       label.font = .smallBold
       label.text = "test"
       return label
    }()

    private lazy var bannerInformationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel, weatherDescriptionLabel, currentTemperatureLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private lazy var bannerContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weatherImageView, bannerInformationStackView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Detail = 체감기온, 최저기온, 최고기온, 현재습도, 기압, 풍속
    private var temperatureImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "thermometer"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBold
        label.text = "기온"
        return label
    }()

    // MARK: 기온
    private var apparentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.text = "test"
        return label
    }()

    private var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.text = "test"
        return label
    }()

    private var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.text = "test"
        return label
    }()

    private lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperatureImageView, temperatureLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    private lazy var temperatureFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [apparentTemperatureLabel, minTemperatureLabel, maxTemperatureLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()

    private lazy var temperatureContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperatureStackView, temperatureFieldStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Other informations
    private var humidityImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "humidity"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBold
        label.text = "습도"
        return label
    }()

    private var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textAlignment = .center
        label.text = "test"
        return label
    }()

    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityImageView, humidityLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    private lazy var humidityContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, humidityValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var pressureImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "tropicalstorm"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBold
        label.text = "기압"
        return label
    }()

    private var pressureValueLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textAlignment = .center
        label.text = "test"

        return label
    }()

    private lazy var pressureStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pressureImageView, pressureLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    private lazy var pressureContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pressureStackView, pressureValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var windImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "wind"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var windLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBold
        label.text = "풍속"
        return label
    }()

    private var windValueLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textAlignment = .center
        label.text = "test: 132435"
        return label
    }()

    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windImageView, windLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    private lazy var windContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windStackView, windValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var detailContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityContainerStackView,
                                                       pressureContainerStackView, windContainerStackView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDisplay()
        configureConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureDisplay() {
        backgroundColor = .secondarySystemBackground
    }

    private func configureConstraints() {
        self.addSubview(bannerContainerStackView)
        self.addSubview(temperatureContainerStackView)
        self.addSubview(detailContainerStackView)

        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalToConstant: CGFloat(100)),
            weatherImageView.heightAnchor.constraint(equalToConstant: CGFloat(100)),
            temperatureImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)),
            temperatureImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)),

            humidityImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)),
            humidityImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)),

            pressureImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)),
            pressureImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)),

            windImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)),
            windImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)),

            bannerContainerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            bannerContainerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            bannerContainerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            bannerContainerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            temperatureContainerStackView.leadingAnchor.constraint(equalTo: bannerContainerStackView.leadingAnchor),
            temperatureContainerStackView.trailingAnchor.constraint(equalTo: bannerContainerStackView.trailingAnchor),
            temperatureContainerStackView.topAnchor.constraint(equalTo: bannerContainerStackView.bottomAnchor, constant: 50),
            temperatureContainerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            detailContainerStackView.leadingAnchor.constraint(equalTo: temperatureContainerStackView.leadingAnchor),
            detailContainerStackView.trailingAnchor.constraint(equalTo: temperatureContainerStackView.trailingAnchor),
            detailContainerStackView.topAnchor.constraint(equalTo: temperatureContainerStackView.bottomAnchor, constant: 50),
            detailContainerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
