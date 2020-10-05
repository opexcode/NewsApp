//
//  NewsItem.swift
//  FinalNews
//
//  Created by Алексей on 05.10.2020.
//

import SwiftUI

struct NewsItem: View {
    var title = "Это заголовок новости"
    
    var body: some View {
        NavigationView {
            VStack {
                Text(title)
                    .font(.title)
                
                ScrollView {
                    Text("""
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ligula est, lacinia eu dui eget, tristique placerat nulla. Sed tincidunt eros eget purus tempor iaculis. Nulla nunc nisi, hendrerit nec lectus id, ullamcorper viverra ante. Phasellus dictum magna ac felis sodales venenatis. Ut tempor scelerisque pulvinar. Fusce quis elementum est, eget feugiat dui. Phasellus vitae elit erat. Pellentesque orci lectus, dapibus eget nulla vel, maximus mollis tellus. Sed magna ex, aliquet sit amet gravida quis, hendrerit eget sem.

                        Etiam auctor facilisis maximus. Ut cursus aliquet sem, nec viverra orci auctor sed. Aenean at magna malesuada, pharetra sapien at, efficitur lacus. Ut arcu neque, sollicitudin eget nibh sit amet, dapibus semper ante. Nulla tincidunt orci et odio volutpat, in sollicitudin augue faucibus. Proin elementum, neque id dignissim rhoncus, magna nisi congue arcu, eget tempor felis metus quis magna. Praesent nec eros vestibulum, varius metus non, vestibulum turpis. Suspendisse sit amet commodo urna. Quisque tempor sollicitudin lacus, non convallis quam aliquet ut. Mauris sit amet lectus ipsum.

                        Maecenas eleifend ornare mauris, non pellentesque quam aliquam et. Proin felis ante, tristique in congue in, porta in nibh. Mauris fringilla nec est vel laoreet. Mauris turpis nisl, efficitur ac justo eu, congue aliquam tellus. Ut fermentum finibus ligula, sit amet fermentum turpis venenatis a. Nam in pharetra libero. Vestibulum quis lacinia tellus, maximus dignissim nisi. Fusce sagittis diam quis odio pulvinar, eu venenatis urna condimentum. Proin quis aliquam arcu. Fusce non augue vitae sem gravida lacinia eu ut dui.
                """)
                }
               
            }
            .padding()
        }
    }
}

