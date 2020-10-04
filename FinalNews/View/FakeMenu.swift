//
//  FakeMenu.swift
//  FinalNews
//
//  Created by Алексей on 04.10.2020.
//

import SwiftUI

struct SideMenu: View {
    
    let menuColor = Color(red: 255/255, green: 111/255, blue: 64/255)
    @State var newsMark = false
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            List {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Image("mainLogo")
                            .resizable()
                            .frame(width: 180, height: 60)
                        Spacer()
                            .frame(width: 130)
                    }
                    
                    HStack(alignment: .top) {
                        Image("user")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        VStack(alignment: .leading) {
                            Text("userName")
                                .fontWeight(.semibold)
                            HStack {
                                Image("user-wallet")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("1000 р.")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    Spacer()
                }
                .listRowBackground(menuColor)
                .foregroundColor(.white)
                
                menuRow(imgName: "news",     rowText: "Новости")
                menuRow(imgName: "chat",     rowText: "Чат")
                menuRow(imgName: "radio",    rowText: "Радио Sova")
                menuRow(imgName: "ski-pass", rowText: "Ски-пасс")
                menuRow(imgName: "market",   rowText: "Объявления")
                menuRow(imgName: "forum",    rowText: "Форум")
                menuRow(imgName: "avto",     rowText: "Авто")
            }
            .listStyle(GroupedListStyle())
            .background(menuColor)
            .edgesIgnoringSafeArea(.all)
            
        }
        
    }
    
    func menuRow(imgName: String, rowText: String) -> some View {
        HStack {
            Image(imgName)
                .resizable()
                .frame(width: 30, height: 26)
            
            Text(rowText)
                .fontWeight(.semibold)
            
            Spacer()
            
            if imgName == "news" {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
            }
        }
        .listRowBackground(menuColor)
        .foregroundColor(.white)
    }
}
