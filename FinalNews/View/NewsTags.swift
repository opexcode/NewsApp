//
//  NewsTags.swift
//  FinalNews
//
//  Created by Алексей on 03.10.2020.
//

import SwiftUI


struct NewsTags: View {
    
    @Environment(\.presentationMode) var presentation
    var fetch: NewsContent
    @State var selectedTag: String?
    @Binding var showTags: Bool
    
    let tagPath = ["Все новости", "Главные новости", "Weekly", "Политика", "Бизнес", "Погода", "Спорт", "Происшествия"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tagPath, id: \.self) { item in
                    SelectionCell(selectedTag: self.$selectedTag, showTags: $showTags, tag: item)
                        .environmentObject(fetch)
                    
                }
                
            }
            
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundColor(appColor)
                    })
        }
    }
}

struct SelectionCell: View {
    
    @EnvironmentObject var fetch: NewsContent
    @Binding var selectedTag: String?
    @Binding var showTags: Bool
    
    let tag: String
    let tagPath = ["Все новости": "news",
                   "Главные новости": "main-news",
                   "Weekly": "weekly",
                   "Политика": "politics",
                   "Бизнес": "business",
                   "Погода": "weather",
                   "Спорт": "sport",
                   "Происшествия": "events"]
    
    var body: some View {
        HStack {
            Button(tag, action: {
                self.showTags.toggle()
                self.selectedTag = self.tag
                
                fetch.newsLabel = self.tag
                fetch.urlPath = "\(tagPath[tag]!)" 
                fetch.contentList.removeAll()
                fetch.getNews()
                
            })
            .font(.headline)
            
            Spacer()
            
            if tag == selectedTag {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                
            }
        }
        .foregroundColor(appColor)
    }
}


