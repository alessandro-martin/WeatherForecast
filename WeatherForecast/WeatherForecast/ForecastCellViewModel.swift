//
//  ForecastCellViewModel.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
import Foundation
import class UIKit.UIImage

final class ForecastCellViewModel: ObservableObject {
    @Published private(set) var image: UIImage = UIImage(systemName: "circle")!
    
    private var cancellable: AnyCancellable?
    
    let description: String
    private let iconId: String
    
    init (description: String, iconId: String) {
        self.description = description
        self.iconId = iconId
    }
    
    func fetchImage() {
        cancellable = Provider.icon(code: iconId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else { return }
                
                self.image = image ?? UIImage(systemName: "circle")!
        }
    }
}
