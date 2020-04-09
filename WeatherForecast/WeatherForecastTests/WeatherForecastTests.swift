//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
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
        
        XCTAssertEqual(sut.forecasts.count, 36)
        XCTAssertEqual(sut.city.name, "Altstadt")
    }
    
    func testSingleForecastIsWellFormed() throws {
        let sut = try JSONDecoder().decode(Response.self, from: fixture).forecasts[0]
        
        XCTAssertEqual(sut.dt, 1487246400)
        XCTAssertEqual(sut.weather.first?.main, "Clear")
        XCTAssertEqual(sut.weather.first?.description, "clear sky")
        XCTAssertEqual(sut.main.tempMin, 281.556)
        XCTAssertEqual(sut.main.tempMax, 286.67)
    }
    
    func testViewModelFetchesData() throws {
        let data = try JSONDecoder().decode(Response.self, from: fixture)
        let sut = ViewModel(weatherProvider: Just(data).eraseToAnyPublisher())
        sut.setUp()
        
        XCTAssertEqual(sut.cityName, "Loading")
        XCTAssertEqual(sut.forecasts.count, 0)
        
        let expectation = self.expectation(description: "City name and forecasts count should be Altstadt and 36")
        DispatchQueue.main.async(execute: expectation.fulfill)
        
        waitForExpectations(timeout: 0.1) { _ in
            XCTAssertEqual(sut.cityName, "Altstadt")
            XCTAssertEqual(sut.forecasts.count, 36)
        }
    }
}
