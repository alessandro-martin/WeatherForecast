//
//  ViewModel.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
import Foundation

final class ViewModel: ObservableObject {
    @Published private(set) var forecasts: [Forecast] = []
    @Published private(set) var cityName: String = "Loading"
    
    private let weatherProvider: AnyPublisher<Response, Never>
    private var cancellable: AnyCancellable?
    
    init(weatherProvider: AnyPublisher<Response, Never> = Provider.weather(city: 2643743)) {
        self.weatherProvider = weatherProvider
    }
    
    func setUp() {
        cancellable = weatherProvider
            .receive(on: DispatchQueue.main)
            .sink { [self] response in
                self.forecasts = response.forecasts
                self.cityName = response.city.name
            }
    }
}
