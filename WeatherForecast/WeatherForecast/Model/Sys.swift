//
//  Sys.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

struct Sys: Codable {
	let pod: String?

	enum CodingKeys: String, CodingKey {

		case pod = "pod"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pod = try values.decodeIfPresent(String.self, forKey: .pod)
	}

}
