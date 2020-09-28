//
//  NewsList.swift
//  NewsApp
//
//  Created by Алексей on 28.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import SwiftUI

struct NewsList: View {
	
	let appColor = Color(red: 255/255, green: 111/255, blue: 64/255)

	@ObservedObject var fetch: NewsContent
	
	var body: some View {
		VStack(alignment: .leading) {
			if let news = fetch.newsResponse {
				
				// Написать логику для даты
				Text("Сегодня, \(news.content[0].label_date)".dropLast(5))
					.font(.system(size: 16, weight: .semibold))
					.foregroundColor(self.appColor)
					.padding()
					.frame(height: 28)
				
//				Divider()
				
				List(news.content) { content in
					NewsCell(
						imageUrl: content.image,
						title: content.title,
						descr: content.descr,
						time: content.time,
						comments: content.comments_count,
						views: content.views_count
					)
				}
			}
		}
	}
}

struct NewsList_Previews: PreviewProvider {
	static var previews: some View {
		NewsList(fetch: NewsContent())
	}
}
