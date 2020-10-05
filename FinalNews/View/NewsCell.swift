//
//  NewsCell.swift
//  FinalNews
//
//  Created by Алексей on 03.10.2020.
//

import SwiftUI

struct NewsCell: View {
    
    var news: Content
    
    var body: some View {
        NavigationLink(destination: NewsItem(title: news.title)) {
            VStack(alignment: .leading) {
                // Изображение
                if news.image != "" {
                    
                    ImageFrom(url: news.image)
                        .cornerRadius(3)
                        .aspectRatio(contentMode: .fit)
                }
                
                HStack {
                    // Заголовок
                    Text(news.title)
                        .font(.body)
                        .fontWeight(.semibold)
                        .lineLimit(nil)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 10)
                
                // Описание
                if news.descr != "" {
                    Text(news.descr)
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
                    
                    Text("\(news.time)")
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    // Форум
                    if news.comments_count != 0 {
                        Image("newsForum")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("\(news.comments_count)")
                            .font(.system(size: 14))
                    }
                    
                    // Просмотры
                    if news.views_count != 0 {
                        Image("newsEye")
                            .resizable()
                            .frame(width: 24, height: 16)
                        Text("\(news.views_count)")
                            .font(.system(size: 14))
                    }
                }
            }
        }
    }
}

