//
//  City.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct City: Codable {
	let id: Int?
	let name: String?
	let coord: Coord?
	let country: String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case coord = "coord"
		case country = "country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
		country = try values.decodeIfPresent(String.self, forKey: .country)
	}

}
