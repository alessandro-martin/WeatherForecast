//
//  Weather.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Weather: Codable {
	let id: Int
	let main: String
	let description: String
	let icon: String
}
