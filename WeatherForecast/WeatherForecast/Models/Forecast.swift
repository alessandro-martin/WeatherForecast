//
//  Forecast.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Forecast: Codable, Identifiable {
    var id: String { String(dt) }
    
	let dt: Int
	let main: Main
	let weather: [Weather]
	let clouds: Clouds
	let wind: Wind
	let sys: Sys
	let dtTxt: String

	enum CodingKeys: String, CodingKey {
		case dt
		case main
		case weather
		case clouds
		case wind
		case sys
		case dtTxt = "dt_txt"
	}
}
