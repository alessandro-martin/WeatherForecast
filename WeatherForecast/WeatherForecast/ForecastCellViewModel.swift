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
    let tempMin: Double
    let tempMax: Double
    let date: Date
}

extension ForecastInfo {
    init(forecast: Forecast) {
        iconId = forecast.weather[0].icon
        description = forecast.weather[0].description
        tempMin = forecast.main.tempMin
        tempMax = forecast.main.tempMax
        date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
    }
}

final class ForecastCellViewModel: ObservableObject {
    @Published private(set) var image: UIImage = UIImage(systemName: "circle")!
    
    var description: String { info.description }
    var temperatures: String { "Min: \(info.tempMin) - Max: \(info.tempMax)" }
    var date: String { "Date: \(info.date)" }
    
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
