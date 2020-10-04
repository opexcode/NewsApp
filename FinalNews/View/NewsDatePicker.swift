//
//  DatePicker.swift
//  NewsAPI
//
//  Created by Алексей on 23.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import SwiftUI


struct NewsDatePicker: View {
    
    @Binding var showPicker: Bool
    @State private var newsDate = Date()
    var fetch: NewsContent
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
				HStack {
					Button("Отмена", action: {
                        self.showPicker = false
                    })
						.frame(width: (geometry.size.width / 2) - 10, height: 45)
						.background(Color.orange)
						.cornerRadius(5)
					
					Button("ОК", action: {
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        fetch.urlPath = formatter.string(from: newsDate)
                        
                        self.showPicker = false
                        fetch.contentList.removeAll()
                        fetch.getNews()
					})
						.frame(width: (geometry.size.width / 2) - 5, height: 45)
						.background(Color(red: 255/255, green: 111/255, blue: 64/255))
						.cornerRadius(5)
				}
				.foregroundColor(.white)
				.padding()
				.font(.system(size: 18, weight: .bold))
				
                HStack {
				DatePicker("",
                           selection: self.$newsDate,
                           in: ...Date(),
                           displayedComponents: .date)
                    .labelsHidden()
					.environment(\.locale, Locale.init(identifier: "ru"))
					.padding(.bottom)
                    .datePickerStyle(WheelDatePickerStyle())
                }
                
			}
			.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
			.background(Color.white)
            
		}
	}
}

