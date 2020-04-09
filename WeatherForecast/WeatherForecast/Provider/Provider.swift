//
//  Provider.swift
//  WeatherForecast
//
//  Created by Alessandro Martin on 08/04/2020.
//  Copyright © 2020 Alessandro Martin. All rights reserved.
//

import Combine
import Foundation
import class UIKit.UIImage

enum Provider {
    static func weather(city: Int) -> AnyPublisher<Response, Never> {
        URLSession.shared
            .dataTaskPublisher(for: Self.url(city: city))
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .replaceError(with: .empty)
            .eraseToAnyPublisher()
    }
    
    static func icon(iconId: String) -> AnyPublisher<UIImage?, Never> {
        let url = Self.url(iconId: iconId)
        if let photo = NSCache.getImage(url: url) {
            return Just(photo).eraseToAnyPublisher()
        } else {
            return fetchPhoto(url: url)
                .flatMap(monadTransformer(cacheImage(for: url))) // Note: here I am performing a side effect which is not ideal but keeps the code simple
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
    
    private static func url(city: Int) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "samples.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [
            .init(name: "id", value: String(city)),
            .init(name: "appid", value: "df603e62bfe5767442581c346e2e18cc")
        ]
        
        return components.url!
    }
    
    private static func url(iconId: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "openweathermap.org"
        components.path = "/img/wn/\(iconId)@2x.png"
        
        return components.url!
    }
    
    private static func fetchPhoto(url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .map(UIImage.init)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    private static func cacheImage(for url: URL) -> (UIImage) -> AnyPublisher<UIImage?, Never> {
        return { image in
            NSCache.setImage(image, for: url)
            
            return Just(image).eraseToAnyPublisher()
        }
    }
}

private extension NSCache where KeyType == NSString, ObjectType == UIImage {
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func getImage(url: URL) -> UIImage? {
        imageCache.object(forKey: url.absoluteString as NSString)
    }
    
    static func setImage(_ image: UIImage, for url: URL) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
}

func monadTransformer<A,B>(_ f: @escaping (A) -> AnyPublisher<B?, Never>) -> (A?) -> AnyPublisher<B?, Never> {
    return { $0.map(f) ?? Just(nil).eraseToAnyPublisher() }
}
