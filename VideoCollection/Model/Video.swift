//
//  Video.swift
//  VideoCollection
//
//  Created by Дмитрий Тараканов on 23.03.2020.
//  Copyright © 2020 Dmitry Angarsky. All rights reserved.
//

import Foundation

struct Video {
    
    let authorName: String
    let videoFileName: String
    let description: String
    let thumbnailFileName: String
    
    static func fetchVideo() -> [Video] {
        
        let v1 = Video(authorName: "David Tran", videoFileName: "Chicago", description: "This is an example of local video.", thumbnailFileName: "Chicago")
        let v2 = Video(authorName: "Tracy Noah", videoFileName: "Dubai", description: "This is an example of local video.", thumbnailFileName: "Dubai")
        let v3 = Video(authorName: "Brendon Burchard", videoFileName: "London", description: "This is an example of local video.", thumbnailFileName: "London")
        let v4 = Video(authorName: "Elon Mask", videoFileName: "Moscow", description: "This is an example of local video.", thumbnailFileName: "Moscow")
        let v5 = Video(authorName: "David Tran", videoFileName: "Singapur", description: "This is an example of local video.", thumbnailFileName: "Singapur")
        let v6 = Video(authorName: "Steve Jobs", videoFileName: "Tokyo", description: "This is an example of local video.", thumbnailFileName: "Tokyo")
        
        return [v1, v2, v3, v4, v5, v6]
    }
}
