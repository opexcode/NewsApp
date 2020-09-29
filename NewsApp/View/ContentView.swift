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
					VStack(alignment: .leading) {
						
						Text("Все новости")
							.font(.system(size: 22, weight: .bold))
							.padding()
							.frame(height: 32)
							
						Divider()
						
						RefreshScrollView(width: geometry.size.width, height: geometry.size.height)
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
									// TODO
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
//                .environmentObject(self.fetch)//
                .gesture(drag)
                .onAppear {
                }
                
                NewsDatePicker()
                    .offset(y: self.showPicker ? (geometry.size.height / 3) : geometry.size.height)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: geometry.size.height / 3)
                
                // Боковое меню
                SideMenu()
                    .offset(x: self.showMenu ? -70 : -geometry.size.width)
                    .frame(width: geometry.size.width * 0.66) //, height: geometry.size.height + 100)
                
            }
            .animation(.spring(response: 0.5, blendDuration: 0.3))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}



