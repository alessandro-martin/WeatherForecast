//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ViewModel
    private var cancellable: AnyCancellable?
    
    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.forecasts) { forecast in
                ForecastCell(
                    viewModel: ForecastCellViewModel(
                        info: .init(forecast: forecast)
                    )
                )
            }
            .onAppear(perform: self.viewModel.setUp)
            .navigationBarTitle(viewModel.cityName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
