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
        URLSession.shared
            .dataTaskPublisher(for: Provider.url(city: city))
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .replaceError(with: .empty)
            .eraseToAnyPublisher()
    }
    
    private static func url(city: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "samples.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [
            .init(name: "q", value: city + ",us"),
            .init(name: "appid", value: "b6907d289e10d714a6e88b30761fae22")
        ]
        
        return components.url!
    }
}
