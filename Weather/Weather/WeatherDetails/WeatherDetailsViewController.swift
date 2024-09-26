//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation
import UIKit

class WeatherDetailsViewController: BaseViewController {
    private var viewModel: WeatherDetailsViewModel!

    private var cityLabel: UILabel!
    private var countryLabel: UILabel!
    private var weatherIconImageView: UIImageView!
    private var temperatureLabel: UILabel!
    private var temperatureUnitLabel: UILabel!
    private var weatherTextLabel: UILabel!

    init(viewModel: WeatherDetailsViewModel!) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }

    private func setupUI() {
        let locationStack = createLocationStack()
        let weatherInfoStack = createTemperatureInfoStack()

        let mainStack = UIStackView(arrangedSubviews: [locationStack, weatherInfoStack])
        mainStack.axis = .vertical
        mainStack.spacing = 40
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.layoutMarginsGuide)
        }
    }

    private func createLocationStack() -> UIStackView {
        let cityLabel = UILabel()
        cityLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        self.cityLabel = cityLabel

        let countryLabel = UILabel()
        countryLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        self.countryLabel = countryLabel

        let locationStack = UIStackView(arrangedSubviews: [cityLabel, countryLabel, Spacer()])
        locationStack.axis = .horizontal
        locationStack.spacing = 5
        locationStack.distribution = .fill
        locationStack.alignment = .firstBaseline

        return locationStack
    }

    private func createTemperatureInfoStack() -> UIStackView {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "--"
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.temperatureLabel = temperatureLabel

        let temperatureUnitLabel = UILabel()
        temperatureUnitLabel.text = "°C"
        self.temperatureUnitLabel = temperatureUnitLabel

        let temperatureStack = UIStackView(arrangedSubviews: [temperatureLabel, temperatureUnitLabel, Spacer()])
        temperatureStack.axis = .horizontal
        temperatureStack.alignment = .top

        let weatherIconImageView = UIImageView()
        self.weatherIconImageView = weatherIconImageView

        weatherIconImageView.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(90)
        }

        let weatherTextLabel = UILabel()
        weatherTextLabel.text = "--"
        self.weatherTextLabel = weatherTextLabel

        let temperatureAndTextStack = UIStackView(arrangedSubviews: [temperatureStack, weatherTextLabel])
        temperatureAndTextStack.axis = .vertical

        let weatherInfoStack = UIStackView(arrangedSubviews: [weatherIconImageView, temperatureAndTextStack])
        weatherInfoStack.axis = .horizontal
        weatherInfoStack.alignment = .center
        weatherInfoStack.spacing = 50

        return weatherInfoStack
    }

    private func setupBindings() {
        let outputs = viewModel.bind(WeatherDetailsViewModel.Inputs())

        outputs.city
            .map { "\($0),"}
            .bind(to: cityLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.country
            .bind(to: countryLabel.rx.text)
            .disposed(by: disposeBag)

        outputs.weatherIconImage
            .bind(to: self.weatherIconImageView.rx.image)
            .disposed(by: disposeBag)

        outputs.temperature
            .map { String(format: "%.0f", $0)}
            .bind(to: temperatureLabel.rx.text)
            .disposed(by: disposeBag)

        let temperatureColor = outputs.temperature
            .map { $0.temperatureColor }

        temperatureColor
            .bind(to: temperatureLabel.rx.textColor)
            .disposed(by: disposeBag)

        temperatureColor
            .bind(to: temperatureUnitLabel.rx.textColor)
            .disposed(by: disposeBag)

        outputs.weatherText
            .bind(to: weatherTextLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

private extension Float {
    var temperatureColor: UIColor {
        if self < 10 {
            return UIColor.blue
        } else if self > 20 {
            return UIColor.red
        } else {
            return UIColor.label // support for dark mode
        }
    }
}
