//
//  ImageFrom.swift
//  FinalNews
//
//  Created by Алексей on 03.10.2020.
//

import SwiftUI

struct ImageFrom: View {
	
	@ObservedObject private var imageLoader = ImageLoader()
	
	var placeholder: Image
	
	init(url: String, placeholder: Image = Image("placeholder")) {
		self.placeholder = placeholder
		self.imageLoader.load(url: url)
	}
	
	var body: some View {
		if let uiImage = self.imageLoader.downloadedImage {
			return Image(uiImage: uiImage).resizable()
		} else {
			return placeholder.resizable()
		}
	}
	
}
