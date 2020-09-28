//
//  NewsCell.swift
//  text
//
//  Created by Алексей on 06.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import SwiftUI


struct NewsCell: View {
    
    let imageUrl: String
    let title: String
    let descr: String
    let time: String
    let comments: Int
    let views: Int
    
    var body: some View {
        VStack {
            // Изображение
            if imageUrl != "" {
                
//                ImageFrom(url: imageUrl)
                
                AsyncImage(
                    url: URL(string: imageUrl)!,
                    placeholder: Text("Loading ...")
                )
                .aspectRatio(contentMode: .fit)
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
                if self.comments != 0 {
                    Image("newsForum")
                        .resizable()
                        .frame(width: 18, height: 18)
                    Text("\(comments)")
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
        NewsCell(imageUrl: "", title: "title", descr: "descr", time: "time", comments: 0, views: 0)
    }
    
}

