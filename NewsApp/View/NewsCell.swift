//
//  NewsCell.swift
//  text
//
//  Created by Алексей on 06.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import SwiftUI


struct NewsCell: View {
	
	let image: String
	let title: String
	let descr: String
	let time: String
	let forum: Int
	let views: Int
	
	var body: some View {
		VStack {
			// Изображение
			if image != "" {
				AsyncImage(
					url: URL(string: image)!,
					placeholder: Text("Loading ...")
				).aspectRatio(contentMode: .fit)
			}
			
			HStack {
				// Заголовок
				Text(title)
					.font(.body)
					.fontWeight(.semibold)
					.lineLimit(nil)
				
				Spacer()
			}
			
			Spacer()
				.frame(height: 10)
			
			// Описание
			if descr != "" {
				Text(descr)
					.font(.callout)
					.fontWeight(.regular)
					.padding(.trailing)
					.lineLimit(3)
			}
			
			HStack {
				// Время
				Image("newsTime")
					.resizable()
					.frame(width: 18, height: 19)
				Text("\(time)")
					.font(.callout)
				
				Spacer()
				
				// Форум
				if self.forum != 0 {
					Image("newsForum")
						.resizable()
						.frame(width: 18, height: 18)
					Text("\(forum)")
						.font(.callout)
				}
				
				// Просмотры
				if views != 0 {
					Image("newsEye")
						.resizable()
						.frame(width: 24, height: 16)
					Text("\(views)")
						.font(.callout)
				}
			}
		}
	}
	
}


struct NewsCell_Previews: PreviewProvider {
	static var previews: some View {
		NewsCell(
			image: newsResponse.content[0].image,
			title: newsResponse.content[0].title,
			descr: newsResponse.content[0].descr,
			time: newsResponse.content[0].time,
			forum: newsResponse.content[0].comments_count,
			views: newsResponse.content[0].views_count
		)
	}
	
}

