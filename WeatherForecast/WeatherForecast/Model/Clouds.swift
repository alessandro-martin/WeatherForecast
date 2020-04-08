//
//  Clouds.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Clouds: Codable {
	let all: Int?

	enum CodingKeys: String, CodingKey {

		case all = "all"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		all = try values.decodeIfPresent(Int.self, forKey: .all)
	}

}
