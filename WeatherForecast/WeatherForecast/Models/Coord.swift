//
//  Coord.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Coord: Codable {
    static let zero = Coord(lat: 0.0, lon: 0.0)
    
	let lat: Double
	let lon: Double
}
