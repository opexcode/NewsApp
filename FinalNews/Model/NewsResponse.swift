//
//  Data.swift
//  NewsAPI
//
//  Created by Алексей on 18.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//
import Foundation
//import SwiftUI

class NewsResponse: Decodable {
    var content: [Content]
    var date: String
    var next_date: String
    var error: String
    var request: [String]
}

struct Content: Decodable, Identifiable {
    var id: String
    var date: String
    var time: String
    var label_date: String
    var title: String
    var descr: String
    var important: String
    var forum_id: Int
    var views_count: Int
    var comments_count: Int
    var image: String
    var tags: [Tags]
}

struct Tags: Decodable {
    var path: String
    var name: String
}
