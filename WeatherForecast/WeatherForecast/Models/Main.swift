//
//  Main.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Main: Codable {
	let temp: Double
	let tempMin: Double
	let tempMax: Double
	let pressure: Double
	let seaLevel: Double
	let groundLevel: Double
	let humidity: Int
	let tempKf: Double

	enum CodingKeys: String, CodingKey {
		case temp
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure
		case seaLevel = "sea_level"
		case groundLevel = "grnd_level"
		case humidity
		case tempKf = "temp_kf"
	}
}
