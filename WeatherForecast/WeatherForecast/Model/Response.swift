//
//  Response.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Response: Codable {
	let cod: String?
	let message: Double?
	let cnt: Int?
	let forecasts: [Forecast]?
	let city: City?

	enum CodingKeys: String, CodingKey {

		case cod = "cod"
		case message = "message"
		case cnt = "cnt"
		case forecasts = "list"
		case city = "city"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cod = try values.decodeIfPresent(String.self, forKey: .cod)
		message = try values.decodeIfPresent(Double.self, forKey: .message)
		cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
		forecasts = try values.decodeIfPresent([Forecast].self, forKey: .forecasts)
		city = try values.decodeIfPresent(City.self, forKey: .city)
	}

}
