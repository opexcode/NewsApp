//
//  Data.swift
//  NewsAPI
//
//  Created by Алексей on 18.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// Подгружаем картинки
class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
}

// Получаем данные JSON c API
class NewsContent: ObservableObject {
    @Published var newsResponse: NewsResponse?
    
    init() {
        newsData()
    }
    
    func newsData() {
        guard let url = URL(string: "https://api.sakh.com/android/ghsJKds78dfsdg/news/list") else { return }
        var request = URLRequest(url: url)
        request.setValue("iOSApp", forHTTPHeaderField: "User-Agent")
        request.setValue("guid=FEDF4350-0F26-4024-BBB7-BFD63B689031(iPhone)", forHTTPHeaderField: "Cookie")
        request.setValue("4509f15b1de09f48dc46cd0ae57ca52d6e4ff5eb1be7c371b44cbed3d29010e4709404e4d5e28c0b", forHTTPHeaderField: "token")
        request.setValue("3.5.8", forHTTPHeaderField: "version")
        request.setValue("62", forHTTPHeaderField: "build")
        request.setValue("true", forHTTPHeaderField: "dev")
        
        URLSession.shared.dataTask(with: request) { [self] data, _, _ in
            guard let data = data else { return }
            let decodedJSON = try! JSONDecoder().decode(NewsResponse.self, from: data)
            DispatchQueue.main.async {
				self.newsResponse = decodedJSON
            }
        }.resume()
    }
}


// Под вопросом
class ImgLoader: ObservableObject {
    
    @Published var downloadedImage: UIImage?
    
    init(url: String) {
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.downloadedImage = UIImage(data: data)
            }
        }.resume()
    }
    
    func getImage(url: String) -> Image {
        var imgData = Data()
        
        if let parsedURL = URL(string: url) {
            URLSession.shared.dataTask(with: parsedURL) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        imgData = data
                    }
                }
            }.resume()
            
            
        }
        
        if let image = UIImage(data: imgData) {
            return Image(uiImage: image)
        } else {
            return Image(systemName: "photo")
        }
    }
}
