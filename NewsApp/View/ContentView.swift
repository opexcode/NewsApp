//
//  ContentView.swift
//  NewsAPI
//
//  Created by Алексей on 17.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import SwiftUI


struct ContentView: View {
	@State private var showPicker = false
	@State var showMenu = false
	@ObservedObject var manager: DataManager
	
	let appColor = Color(red: 255/255, green: 111/255, blue: 64/255)
	
	var body: some View {
		let drag = DragGesture()
			.onEnded {
				if $0.translation.width > -100 {
					withAnimation {
						self.showMenu.toggle()
					}
				} else if $0.translation.width < -100 {
					withAnimation {
						self.showMenu.toggle()
					}
				}
		}
		
		return GeometryReader { geometry  in
			ZStack {
				NavigationView {
					VStack {
						HStack(alignment: .center) {
							Text("Все новости")
								.font(.system(size: 22, weight: .bold))
								.multilineTextAlignment(.leading)
								.padding(.horizontal)
								.frame(height: 35)
							Spacer()
						}
						
						HStack {
							Text("Сегодня, \(self.manager.dataModel[0].label_date)".dropLast(5))
								.font(.system(size: 16, weight: .semibold))
								.foregroundColor(self.appColor)
								.padding(.horizontal)
								.frame(height: 30)
							Spacer()
						}
						
						List(self.manager.dataModel) { content in
							NewsCell(
								image: content.image,
								title: content.title,
								descr: content.descr,
								time: content.time,
								forum: content.comments_count,
								views: content.views_count
							)
						}
					}
						// Скрываем picker по тапу
						.onTapGesture {
							if self.showPicker {
								self.showPicker = false
							}
					}
					.navigationBarTitle("Новости", displayMode: .inline)
					.navigationBarItems(
						leading:
						HStack {
							Button(action: {
								withAnimation {
									self.showMenu.toggle()
								}
							})
							{
								Image(systemName: "line.horizontal.3")
									.imageScale(.large)
							}
							Spacer()
							
							Button(action: {
								self.showPicker.toggle()
							})
							{
								Image(systemName: "calendar")
									.imageScale(.large)
									.frame(width: 80)
							}
						}
						.foregroundColor(self.appColor),
						
						trailing:
						HStack {
							Button(action: {
								//TODeO
							})
							{
								Image(systemName: "ellipsis")
									.imageScale(.large)
							}
						}
						.foregroundColor(self.appColor)
					)
				}
				.colorMultiply(self.showPicker ? .gray : .white)
					.environmentObject(self.manager)//
					.gesture(drag)
					.onAppear {
						newsResponse = load()
				}
				
				NewsDatePicker()
					.offset(y: self.showPicker ? 180 : geometry.size.height)
				
				// Боковое меню
				SideMenu()
					.offset(x: self.showMenu ? -65 : -geometry.size.width)
					.frame(width: geometry.size.width * 0.66) //, height: geometry.size.height + 100)
				
			}
			.animation(.spring(response: 0.5, blendDuration: 0.3))
		}
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(manager: DataManager(dataModel: content))
	}
	
}



