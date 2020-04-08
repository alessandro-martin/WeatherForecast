//
//  Wind.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Wind: Codable {
	let speed: Double?
	let deg: Double?

	enum CodingKeys: String, CodingKey {

		case speed = "speed"
		case deg = "deg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		speed = try values.decodeIfPresent(Double.self, forKey: .speed)
		deg = try values.decodeIfPresent(Double.self, forKey: .deg)
	}

}
