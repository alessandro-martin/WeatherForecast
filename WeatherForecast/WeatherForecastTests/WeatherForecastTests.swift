//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import XCTest
@testable import WeatherForecast

final class WeatherForecastTests: XCTestCase {
    private var fixture: Data!
   
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        
        fixture = Bundle(for: WeatherForecastTests.self)
            .url(forResource: "response", withExtension: "json")
            .map { try! Data(contentsOf: $0) }
    }

    func testResponseIsDecodedCorrectly() throws {
        let sut = try JSONDecoder().decode(Response.self, from: fixture)
        
        XCTAssertEqual(sut.forecasts?.count, 36)
    }
    
    func testSingleForecastIsWellFormed() throws {
        let sut = try JSONDecoder().decode(Response.self, from: fixture).forecasts![0]
        
        XCTAssertEqual(sut.dt, 1487246400)
        XCTAssertEqual(sut.weather?.first?.main, "Clear")
        XCTAssertEqual(sut.weather?.first?.description, "clear sky")
        XCTAssertEqual(sut.main?.temp_min, 281.556)
        XCTAssertEqual(sut.main?.temp_max, 286.67)
    }
}
