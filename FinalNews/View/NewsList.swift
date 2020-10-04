//
//  NewsList.swift
//  FinalNews
//
//  Created by Алексей on 03.10.2020.
//

import SwiftUI

struct NewsList: View {
    
    @ObservedObject var fetch = NewsContent()
    @State var onAppear = false
    @State var dateLable = ""
    
    var body: some View {
        if let news = fetch.newsResponse {
            VStack (alignment: .leading) {
                
                DateLabel()
                    .environmentObject(fetch)
                
                Divider()
                    .frame(height: 1)
     
                
                List(0..<fetch.contentList.count, id: \.self) { i in
                    // TODO func
                    // Подгружаем новости на следующую дату
                    if i == fetch.contentList.count - 1 {
                        NewsCell(news: fetch.contentList[i])
                            .onAppear() {
                                if !onAppear {
                                    print("Load news")
                                    self.onAppear = true
                                    fetch.urlPath = news.next_date
                                    fetch.getNews()
                                } else {
                                    self.onAppear = false
                                }
                            }
                    } else {
                        NewsCell(news: fetch.contentList[i])
                    }
                }.padding(.top, -8)
            }
        }
    }
}


struct DateLabel: View {
    
    @EnvironmentObject var date: NewsContent
    
    var body: some View {
        Text("\(date.newsResponse!.content[0].label_date)")
            .frame(height: 26)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(appColor)
            .padding(.leading)
        
    }
}
