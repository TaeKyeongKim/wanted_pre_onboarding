//
//  CityWeatherCell.swift
//  weather_app
//
//  Created by Kai Kim on 2022/06/15.
//

import UIKit

final class CityWeatherCell: UICollectionViewCell {

    static let id = "CityWeatherCell"

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "multiply")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var cityName: UILabel = {
        let label  = UILabel()
        label.font = .smallBold
        label.text = "testtest"
        return label
    }()

    private var temperature: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .systemGray3
        label.text = "testtest"
        return label
    }()

    private var humidity: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.text = "testtest"
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
        contentView.addSubview(imageView)
        contentView.addSubview(informationContainerStackView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.width/1.4),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            informationContainerStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            informationContainerStackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
