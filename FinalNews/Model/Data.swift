//
//  Data.swift
//  NewsAPI
//
//  Created by Алексей on 18.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import Foundation
import SwiftUI

let appColor = Color(red: 255/255, green: 111/255, blue: 64/255)

// Подгружаем картинки
class ImageLoader: ObservableObject {
	
	@Published var downloadedImage: UIImage?
	
	var imageCache = ImageCache.getImageCache()
	
	func load(url: String) {
		if loadImageFromCache(url: url) {
			print("Load image from cache")
			return
		}
		
		print("Cache miss, load image from url")
		guard let imageURL = URL(string: url) else {
			fatalError("ImageURL is not correct!")
		}
		
		URLSession.shared.dataTask(with: imageURL) { data, response, error in
			guard let data = data, error == nil else {
				return
			}
			DispatchQueue.main.async {
				guard let loadedImage = UIImage(data: data) else { return }
				
				self.imageCache.set(forKey: url, image: loadedImage)
				self.downloadedImage = loadedImage
			}
		}.resume()
	}
	
	func loadImageFromCache(url: String) -> Bool {
		guard let cacheImage = imageCache.get(forKey: url) else { return false }
		
		self.downloadedImage = cacheImage
		return true
	}

}


class ImageCache {
	var cache = NSCache<NSString, UIImage>()
	
	func get(forKey: String) -> UIImage? {
		return cache.object(forKey: NSString(string: forKey))
	}
	
	func set(forKey: String, image: UIImage) {
		cache.setObject(image, forKey: NSString(string: forKey))
	}
}


extension ImageCache {
	private static var imageCache = ImageCache()
	static func getImageCache() -> ImageCache {
		return imageCache
	}
}


// Получаем данные JSON c API
class NewsContent: ObservableObject {
    @Published var newsLabel = "Все новости"
    @Published var newsResponse: NewsResponse?
	@Published var contentList = [Content]()
	
	var urlPath = ""
    
    init() {
		getNews()
    }
    
    func getNews() {
		guard let url = URL(string: "https://api.sakh.com/android/ghsJKds78dfsdg/news/list/" + urlPath) else { return }
        var request = URLRequest(url: url)
        request.setValue("iOSApp", forHTTPHeaderField: "User-Agent")
        request.setValue("guid=FEDF4350-0F26-4024-BBB7-BFD63B689031(iPhone)", forHTTPHeaderField: "Cookie")
        request.setValue("4509f15b1de09f48dc46cd0ae57ca52d6e4ff5eb1be7c371b44cbed3d29010e4709404e4d5e28c0b", forHTTPHeaderField: "token")
        request.setValue("3.5.8", forHTTPHeaderField: "version")
        request.setValue("62", forHTTPHeaderField: "build")
        request.setValue("true", forHTTPHeaderField: "dev")
        
        URLSession.shared.dataTask(with: request) { [self] data, _, _ in
            guard let data = data else { return }
            let json = try? JSONDecoder().decode(NewsResponse.self, from: data)
			let oldData = self.contentList
            DispatchQueue.main.async {
				self.newsResponse = json
				if let json = json {
					self.contentList = oldData + json.content
				}
				
            }
        }.resume()
    }
	
	func reloadNews() {
		self.contentList.removeAll()
		self.urlPath = ""
		self.getNews()
	}
    
}

