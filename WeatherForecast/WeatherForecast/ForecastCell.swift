//
//  ForecastCell.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
import SwiftUI

struct ForecastCell: View {
    @ObservedObject private var viewModel: ForecastCellViewModel
    
    init(viewModel: ForecastCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .frame(width: 90.0, height: 90.0)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 4.0) {
                Text(viewModel.description)
                    .fontWeight(.bold)
                Spacer(minLength: 4.0)
                Text(viewModel.temperatures)
                Text(viewModel.date)
            }
        }.onAppear(perform: self.viewModel.fetchImage)
    }
}

struct ForecastCell_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCell(
            viewModel: ForecastCellViewModel(
                info: ForecastInfo(
                    iconId: "01D",
                    description: "clear sky",
                    tempMin: 291.11,
                    tempMax: 299.23,
                    date: Date(timeIntervalSince1970: 1487246400)
                )
            )
        )
    }
}
