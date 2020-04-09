//
//  ForecastCellViewModel.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
import Foundation
import class UIKit.UIImage

struct ForecastInfo {
    let iconId: String
    let description: String
    let tempMin: Measurement<UnitTemperature>
    let tempMax: Measurement<UnitTemperature>
    let date: Date
}

extension ForecastInfo {
    init(forecast: Forecast) {
        iconId = forecast.weather[0].icon
        description = forecast.weather[0].description
        tempMin = Measurement(
            value: forecast.main.tempMin,
            unit: .kelvin
        ).converted(to: .celsius)
        tempMax = Measurement(
            value: forecast.main.tempMax,
            unit: .kelvin
        ).converted(to: .celsius)
        date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
    }
}

final class ForecastCellViewModel: ObservableObject {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    @Published private(set) var image: UIImage = UIImage(systemName: "circle")!
    
    var description: String { info.description }
    var temperatures: String { "T Min: \(Self.numberFormatter.string(from: NSNumber(value: info.tempMin.value)) ?? "n/a") - T Max: \(Self.numberFormatter.string(from: NSNumber(value: info.tempMax.value)) ?? "n/a")" }
    var date: String { "Date: \(Self.dateFormatter.string(from: info.date))" }
    
    private var cancellable: AnyCancellable?
    
    private let info: ForecastInfo
    
    init(info: ForecastInfo) {
        self.info = info
    }
    
    func fetchImage() {
        cancellable = Provider.icon(iconId: info.iconId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else { return }
                
                self.image = image ?? UIImage(systemName: "circle")!
        }
    }
}
