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
    
    private var cancellable: AnyCancellable?
    
    func setUp() {
        let url = URL(string: "https://samples.openweathermap.org/data/2.5/forecast?q=London,us&appid=b6907d289e10d714a6e88b30761fae22")!
        cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [self] response in
                self.forecasts = response.forecasts
                self.cityName = response.city.name
        }
    }
}
