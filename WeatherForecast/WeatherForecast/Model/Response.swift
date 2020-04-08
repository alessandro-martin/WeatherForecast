//
//  Response.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Response: Codable {
	let cod: String
	let message: Double
	let cnt: Int
	let forecasts: [Forecast]
	let city: City

	enum CodingKeys: String, CodingKey {
		case cod
		case message
		case cnt
		case forecasts = "list"
		case city
	}
}
