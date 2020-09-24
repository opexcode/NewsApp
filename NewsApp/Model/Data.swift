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



class DataManager: ObservableObject {
	@Published var dataModel: [Content]
	
	init(dataModel: [Content]) {
		self.dataModel = dataModel
	}
	
}

var newsResponse: NewsResponse = load()
var content: [Content] = newsResponse.content


func load<T: Decodable>(as type: T.Type = T.self) -> T {
	var mydata = Data()
	
	do {
		let url = URL(string: "https://api.sakh.com/android/ghsJKds78dfsdg/news/list") // guard
		var request = URLRequest(url: url!)
		request.setValue("iOSApp", forHTTPHeaderField: "User-Agent")
		request.setValue("guid=FEDF4350-0F26-4024-BBB7-BFD63B689031(iPhone)", forHTTPHeaderField: "Cookie")
		request.setValue("4509f15b1de09f48dc46cd0ae57ca52d6e4ff5eb1be7c371b44cbed3d29010e4709404e4d5e28c0b", forHTTPHeaderField: "token")
		request.setValue("3.5.8", forHTTPHeaderField: "version")
		request.setValue("62", forHTTPHeaderField: "build")
		request.setValue("true", forHTTPHeaderField: "dev")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else { return }
			mydata = data
		}.resume()
		
		sleep(3)
        
		return try JSONDecoder().decode(T.self, from: mydata)
	} catch {
		fatalError("Couldn't parse as \(T.self):\n\(error)")
	}
	
}
