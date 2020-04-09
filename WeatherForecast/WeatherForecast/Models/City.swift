//
//  City.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct City: Codable {
    static let empty = City(
        id: 0,
        name: "",
        coord: .zero,
        country: ""
    )
    
	let id: Int
	let name: String
	let coord: Coord
	let country: String
}
