//
//  ContentView.swift
//  FinalNews
//
//  Created by Алексей on 03.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showTags = false
    @State private var showPicker = false
    @State var showMenu = false
    @ObservedObject var fetch = NewsContent()
  
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded { value in
                if !showPicker {
                    if value.translation.width > -100 {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    } else if value.translation.width < -100 {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }
                }
            }
        
        return GeometryReader { g in
            ZStack {
                NavigationView {
                    VStack(alignment: .leading) {
                        List {
                            Text(fetch.newsLabel)
                                .font(.system(size: 22, weight: .bold))
                        }
                        .padding(.leading, -12)
                        .frame(height: 32)
                        
                        RefreshNewsList(width: g.size.width, height: g.size.height - 100, fetch: fetch)
                        
                    }
                    // Настройки NavigationBar
                    .navigationBarTitle("Новости", displayMode: .inline)
                    .navigationBarItems(
                        leading: BarItemsLeading(showPicker: $showPicker, showMenu: $showMenu),
                        trailing: BarItemsTrailing(showTags: $showTags)
                    )
                    
                }
                .listStyle(PlainListStyle())
                .colorMultiply(self.showPicker ? .gray : .white)
                .gesture(drag)
                
                // Модальное окно с рубриками
                .sheet(isPresented: $showTags) {
                    NewsTags(fetch: fetch, showTags: $showTags)
                }
                
                // Новости по дате
                NewsDatePicker(showPicker: $showPicker, fetch: fetch)
                    .offset(y: self.showPicker ? (g.size.height / 3) + 10 : g.size.height)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: g.size.height / 3)
//                    .environmentObject(fetch)
                
                // Боковое меню
                SideMenu()
                    .offset(x: self.showMenu ? -74 : -g.size.width)
                    .frame(width: g.size.width * 0.66)
                
                
            }
            .animation(.spring())
        }
    }
}


struct BarItemsLeading: View  {
    @Binding var showPicker: Bool
    @Binding var showMenu: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.showMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }
            .frame(width: 30, height: 30)
            
            Spacer(minLength: 30)
            
            Button(action: {
                self.showPicker.toggle()
                print(showPicker)
            }) {
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .frame(width: 80)
            }
            .frame(width: 30, height: 30)
        }
        .foregroundColor(appColor)
    }
}


struct BarItemsTrailing: View  {
    @Binding var showTags: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                self.showTags.toggle()
            }) {
                Image(systemName: "ellipsis")
                    .imageScale(.large)
            }
        }
        .frame(width: 30, height: 30)
        .foregroundColor(appColor)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
