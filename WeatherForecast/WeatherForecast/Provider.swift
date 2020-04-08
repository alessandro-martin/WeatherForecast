//
//  Provider.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
import Foundation

enum Provider {
    static func weather(city: String) -> AnyPublisher<Response, Never> {
        let url = URL(string: "https://samples.openweathermap.org/data/2.5/forecast?q=London,us&appid=b6907d289e10d714a6e88b30761fae22")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .replaceError(with: .empty)
            .eraseToAnyPublisher()
    }
}
