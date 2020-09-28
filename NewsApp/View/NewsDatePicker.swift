//
//  NewsDatePicker.swift
//  NewsAPI
//
//  Created by Алексей on 23.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import SwiftUI


struct NewsDatePicker: View {
	@State private var newsDate = Date()
	
	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "YYYY-MM-DD"
		return formatter
	}
	
	var body: some View {
		GeometryReader { geometry in
			VStack(alignment: .center, spacing: 5) {
				HStack {
					Button("Отмена", action: {})
						.frame(width: (geometry.size.width / 2) - 10, height: 45)
						.background(Color.orange)
						.cornerRadius(5)
					
					Button("ОК", action: {})
						.frame(width: (geometry.size.width / 2) - 10, height: 45)
						.background(Color(red: 255/255, green: 111/255, blue: 64/255))
						.cornerRadius(5)
				}
				.foregroundColor(.white)
				.padding()
				.font(.system(size: 18, weight: .bold))
				
				
				DatePicker("", selection: self.$newsDate, displayedComponents: .date)
					.environment(\.locale, Locale.init(identifier: "ru"))
					.padding(.bottom)
				
			}
			.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
			.background(Color.white)
		}
	}
}

struct NewsDatePicker_Previews: PreviewProvider {
	static var previews: some View {
		NewsDatePicker()
	}
}
