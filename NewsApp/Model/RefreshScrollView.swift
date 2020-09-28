//
//  RefreshScrollView.swift
//  NewsApp
//
//  Created by Алексей on 28.09.2020.
//  Copyright © 2020 Alexey Orekhov. All rights reserved.
//

import UIKit
import SwiftUI

struct RefreshScrollView: UIViewRepresentable {
	var width: CGFloat
	var height: CGFloat
	
	var fetch = NewsContent()
	
	func makeUIView(context: Context) -> UIScrollView {
		let scrollView = UIScrollView()
		scrollView.refreshControl = UIRefreshControl()
		
		scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl(sender:)), for: .valueChanged)
		
		let refreshVC = UIHostingController(rootView: NewsList(fetch: fetch)) // 
		refreshVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
		
		scrollView.addSubview(refreshVC.view)
		
		return scrollView
	}
	
	func updateUIView(_ uiView: UIScrollView, context: Context) {}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self, fetch: fetch) // TODO
	}
	
	class Coordinator: NSObject {
		var refreshScrollView: RefreshScrollView
		var fetch: NewsContent // TODO
		
		init(_ refreshScrollView: RefreshScrollView, fetch: NewsContent) {
			self.refreshScrollView = refreshScrollView
			self.fetch = fetch
		}
		
		@objc func handleRefreshControl(sender: UIRefreshControl) {
			sender.endRefreshing()
			// RELOAD data
			fetch.load()
		}
	}
}
